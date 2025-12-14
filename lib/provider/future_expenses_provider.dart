import 'package:flutter/foundation.dart';
import '../models/future_expense.dart';
import 'finance_boxes.dart';

class FutureExpensesProvider extends ChangeNotifier {
  List<FutureExpense> _items = [];

  List<FutureExpense> get items => List.unmodifiable(_items);

  List<FutureExpense> get planned =>
      _items.where((e) => !e.isPurchased).toList()
        ..sort(_wishlistSort);

  List<FutureExpense> get purchased =>
      _items.where((e) => e.isPurchased).toList()
        ..sort((a, b) => b.dueDateOrMax.compareTo(a.dueDateOrMax));

  double get totalPlannedEstimated =>
      planned.fold<double>(0, (sum, e) => sum + (e.estimatedCost ?? 0));

  Future<void> load() async {
    final box = FinanceBoxes.futureExpenses;
    _items = box.values.toList();
    _items.sort(_wishlistSort);
    notifyListeners();
  }

  Future<void> addFutureExpense(FutureExpense item) async {
    await FinanceBoxes.futureExpenses.add(item);
    await load();
  }

  Future<void> togglePurchased(FutureExpense item) async {
    item.isPurchased = !item.isPurchased;
    await item.save();
    await load();
  }

  Future<void> deleteFutureExpense(FutureExpense item) async {
    await item.delete();
    await load();
  }

  static int _wishlistSort(FutureExpense a, FutureExpense b) {
    // Higher priority first
    final p = b.priority.compareTo(a.priority);
    if (p != 0) return p;

    // Earlier due date first (nulls last)
    final ad = a.dueDateOrMax;
    final bd = b.dueDateOrMax;
    final d = ad.compareTo(bd);
    if (d != 0) return d;

    return a.title.toLowerCase().compareTo(b.title.toLowerCase());
  }
}

extension _FutureExpenseDateX on FutureExpense {
  DateTime get dueDateOrMax => dueDate ?? DateTime(9999);
}
