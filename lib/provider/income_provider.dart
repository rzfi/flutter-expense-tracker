import 'package:flutter/foundation.dart';
import '../models/income.dart';
import 'finance_boxes.dart';

class IncomeProvider extends ChangeNotifier {
  List<Income> _items = [];

  List<Income> get items => List.unmodifiable(_items);

  double get totalConfirmed =>
      _items.where((i) => i.isConfirmed).fold<double>(0, (sum, i) => sum + i.amount);

  double get totalAll =>
      _items.fold<double>(0, (sum, i) => sum + i.amount);

  Future<void> load() async {
    final box = FinanceBoxes.incomes;
    _items = box.values.toList();
    _items.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  /// Step 1: create income but keep it unconfirmed (UI shows confirmation screen/dialog).
  Future<void> addIncomeDraft(Income income) async {
    final draft = Income(
      id: income.id,
      source: income.source,
      amount: income.amount,
      date: income.date,
      description: income.description,
      isConfirmed: false,
    );
    await FinanceBoxes.incomes.add(draft);
    await load();
  }

  /// Step 2: confirm the draft so it counts in the budget/net balance.
  Future<void> confirmIncome(Income income) async {
    income.isConfirmed = true;
    await income.save();
    await load();
  }

  Future<void> deleteIncome(Income income) async {
    await income.delete();
    await load();
  }
}
