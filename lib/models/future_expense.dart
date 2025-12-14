import 'package:hive/hive.dart';

part 'future_expense.g.dart';

@HiveType(typeId: 2)
class FutureExpense extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  double? estimatedCost;

  @HiveField(3)
  int priority; // 1: Low, 2: Medium, 3: High

  @HiveField(4)
  DateTime? dueDate;

  @HiveField(5)
  bool isPurchased;

  @HiveField(6)
  String category; // To match with expense categories

  @HiveField(7)
  String? notes;

  FutureExpense({
    required this.id,
    required this.title,
    this.estimatedCost,
    this.priority = 1,
    this.dueDate,
    this.isPurchased = false,
    this.category = 'General',
    this.notes,
  });
}
