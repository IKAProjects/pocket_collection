import 'package:hive/hive.dart';

part 'item_model.g.dart';

@HiveType(typeId: 1)
class ItemModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? imagePath;

  @HiveField(3)
  final int number;

  @HiveField(4)
  final double? price;

  @HiveField(5)
  final String type;

  @HiveField(6)
  final String? collectionId;

  @HiveField(7)
  final DateTime? createdDate;

  ItemModel({
    required this.id,
    required this.name,
    this.imagePath,
    required this.number,
    this.price,
    required this.type,
    this.collectionId,
    this.createdDate,
  });
}