// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_contact.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveContactAdapter extends TypeAdapter<HiveContact> {
  @override
  final int typeId = 1;

  @override
  HiveContact read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveContact()
      ..name = fields[0] as String
      ..phoneNumber = fields[1] as String
      ..about = fields[2] as String
      ..isInContactList = fields[3] as bool;
  }

  @override
  void write(BinaryWriter writer, HiveContact obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(2)
      ..write(obj.about)
      ..writeByte(3)
      ..write(obj.isInContactList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveContactAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
