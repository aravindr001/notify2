// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationDataModelAdapter extends TypeAdapter<NotificationDataModel> {
  @override
  final int typeId = 1;

  @override
  NotificationDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationDataModel(
      title: fields[0] as String,
      text: fields[1] as String,
      packageName: fields[2] as String,
      createAt: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationDataModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.packageName)
      ..writeByte(3)
      ..write(obj.createAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
