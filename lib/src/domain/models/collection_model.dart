import 'package:hive/hive.dart';
import 'item_model.dart';

part 'collection_model.g.dart';

@HiveType(typeId: 0)
class CollectionModel {
  @HiveField(0)
  final String category;

  @HiveField(1)
  final String iconPath;

  @HiveField(2)
  final String collectionName;

  @HiveField(3)
  final int? itemCount;

  @HiveField(4)
  final String id;

  @HiveField(5)
  final List<ItemModel> items;

  CollectionModel({
    required this.category,
    required this.iconPath,
    required this.collectionName,
    this.itemCount,
    required this.id,
    required this.items,
  });
}