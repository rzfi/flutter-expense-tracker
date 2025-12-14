import 'package:flutter/foundation.dart';
import '../models/budget.dart';
import 'finance_boxes.dart';
import 'expenses_provider.dart';

class BudgetProvider extends ChangeNotifier {
  Budget? _active;

  /// The active budget object (weekly/monthly/overall).
  Budget? get activeBudget => _active;

  /// Backward compatible getter used by HomeScreen (expects a double).
  /// If no budget is set, returns 0.
  double get budget => _active?.limit ?? 0.0;

  /// Convenience: whether a budget exists.
  bool get hasBudget => _active != null && (_active!.limit > 0);

  Future<void> load() async {
    _active = FinanceBoxes.budgets.get(FinanceBoxes.activeBudgetKey);
    notifyListeners();
  }

  /// Compatibility method for your current UI ("Set Overall Budget").
  /// Stores an always-valid "overall" budget that spans a long time window.
  Future<void> setBudget(double limit) async {
    final now = DateTime.now();
    final budget = Budget(
      id: 'overall_${now.millisecondsSinceEpoch}',
      limit: limit,
      period: 'overall',
      startDate: DateTime(2000, 1, 1),
      endDate: DateTime(2100, 12, 31, 23, 59, 59),
      isActive: true,
      warningThreshold: 0.9,
    );

    await FinanceBoxes.budgets.put(FinanceBoxes.activeBudgetKey, budget);
    await load();
  }

  Future<void> setWeeklyBudget({
    required String id,
    required double limit,
    required DateTime weekStart, // choose Monday in UI
    double warningThreshold = 0.9,
  }) async {
    final start = DateTime(weekStart.year, weekStart.month, weekStart.day);
    final end = start.add(
      const Duration(days: 6, hours: 23, minutes: 59, seconds: 59),
    );

    final budget = Budget(
      id: id,
      limit: limit,
      period: 'weekly',
      startDate: start,
      endDate: end,
      isActive: true,
      warningThreshold: warningThreshold,
    );

    await FinanceBoxes.budgets.put(FinanceBoxes.activeBudgetKey, budget);
    await load();
  }

  Future<void> setMonthlyBudget({
    required String id,
    required double limit,
    required DateTime anyDayInMonth,
    double warningThreshold = 0.9,
  }) async {
    final start = DateTime(anyDayInMonth.year, anyDayInMonth.month, 1);

    final nextMonth = (anyDayInMonth.month == 12)
        ? DateTime(anyDayInMonth.year + 1, 1, 1)
        : DateTime(anyDayInMonth.year, anyDayInMonth.month + 1, 1);

    final end = nextMonth.subtract(const Duration(seconds: 1));

    final budget = Budget(
      id: id,
      limit: limit,
      period: 'monthly',
      startDate: start,
      endDate: end,
      isActive: true,
      warningThreshold: warningThreshold,
    );

    await FinanceBoxes.budgets.put(FinanceBoxes.activeBudgetKey, budget);
    await load();
  }

  Future<void> clearBudget() async {
    await FinanceBoxes.budgets.delete(FinanceBoxes.activeBudgetKey);
    await load();
  }

  /// Derived stats (needs expenses provider data)
  double spentInActivePeriod(ExpensesProvider expenses) {
    final b = _active;
    if (b == null) return 0;
    return expenses.totalBetween(b.startDate, b.endDate);
  }

  double remainingInActivePeriod(ExpensesProvider expenses) {
    final b = _active;
    if (b == null) return 0;
    return (b.limit - spentInActivePeriod(expenses));
  }

  double usageRatio(ExpensesProvider expenses) {
    final b = _active;
    if (b == null || b.limit <= 0) return 0;
    return (spentInActivePeriod(expenses) / b.limit).clamp(0, 10);
  }

  bool isNearLimit(ExpensesProvider expenses) {
    final b = _active;
    if (b == null) return false;
    final ratio = usageRatio(expenses);
    return ratio >= b.warningThreshold && ratio < 1;
  }

  bool isOverLimit(ExpensesProvider expenses) {
    return usageRatio(expenses) >= 1;
  }
}
