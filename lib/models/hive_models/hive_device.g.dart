// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_device.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveDeviceAdapter extends TypeAdapter<HiveDevice> {
  @override
  final int typeId = 2;

  @override
  HiveDevice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveDevice()..lastCheckedContactCount = fields[0] as int;
  }

  @override
  void write(BinaryWriter writer, HiveDevice obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.lastCheckedContactCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveDeviceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
