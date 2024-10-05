// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CollectionModelAdapter extends TypeAdapter<CollectionModel> {
  @override
  final int typeId = 0;

  @override
  CollectionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CollectionModel(
      category: fields[0] as String,
      iconPath: fields[1] as String,
      collectionName: fields[2] as String,
      itemCount: fields[3] as int?,
      id: fields[4] as String,
      items: (fields[5] as List).cast<ItemModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, CollectionModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.iconPath)
      ..writeByte(2)
      ..write(obj.collectionName)
      ..writeByte(3)
      ..write(obj.itemCount)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
