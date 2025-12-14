// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'future_expense.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FutureExpenseAdapter extends TypeAdapter<FutureExpense> {
  @override
  final int typeId = 2;

  @override
  FutureExpense read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FutureExpense(
      id: fields[0] as String,
      title: fields[1] as String,
      estimatedCost: fields[2] as double?,
      priority: fields[3] as int,
      dueDate: fields[4] as DateTime?,
      isPurchased: fields[5] as bool,
      category: fields[6] as String,
      notes: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FutureExpense obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.estimatedCost)
      ..writeByte(3)
      ..write(obj.priority)
      ..writeByte(4)
      ..write(obj.dueDate)
      ..writeByte(5)
      ..write(obj.isPurchased)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(7)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FutureExpenseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
