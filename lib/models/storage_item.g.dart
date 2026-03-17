// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StorageItemAdapter extends TypeAdapter<StorageItem> {
  @override
  final int typeId = 0;

  @override
  StorageItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StorageItem(
      id: fields[0] as int,
      name: fields[1] as String,
      location: fields[2] as String,
      note: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StorageItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StorageItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
