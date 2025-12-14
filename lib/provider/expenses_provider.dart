import 'package:flutter/foundation.dart';
import '../models/expense.dart';
import 'finance_boxes.dart';

class ExpensesProvider extends ChangeNotifier {
  List<Expense> _items = [];

  List<Expense> get items => List.unmodifiable(_items);

  /// Total of all expenses.
  double get total =>
      _items.fold<double>(0, (sum, e) => sum + (e.amount));

  Future<void> load() async {
    final box = FinanceBoxes.expenses;
    _items = box.values.toList();

    // Sort: latest first
    _items.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    await FinanceBoxes.expenses.add(expense);
    await load();
  }

  Future<void> updateExpense(Expense expense) async {
    // Because Expense extends HiveObject, it has save()
    await expense.save();
    await load();
  }

  Future<void> deleteExpense(Expense expense) async {
    await expense.delete();
    await load();
  }

  /// Helpers for budget/report calculations
  double totalBetween(DateTime start, DateTime endInclusive) {
    return _items
        .where((e) => !e.date.isBefore(start) && !e.date.isAfter(endInclusive))
        .fold<double>(0, (sum, e) => sum + e.amount);
  }

  Map<String, double> categoryTotalsBetween(DateTime start, DateTime endInclusive) {
    final Map<String, double> out = {};
    for (final e in _items.where(
        (e) => !e.date.isBefore(start) && !e.date.isAfter(endInclusive))) {
      out[e.category] = (out[e.category] ?? 0) + e.amount;
    }
    return out;
  }
}
