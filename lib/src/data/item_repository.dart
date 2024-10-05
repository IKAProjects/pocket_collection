import 'package:hive/hive.dart';
import '../domain/models/item_model.dart';

class ItemRepository {
  final Box<ItemModel> itemBox;

  ItemRepository(this.itemBox);

  Future<List<ItemModel>> getAllItems() async {
    return itemBox.values.toList();
  }

  Future<ItemModel?> getItemById(String id) async {
    return itemBox.get(id);
  }

  Future<void> addItem(ItemModel item) async {
    await itemBox.put(item.id, item);
  }

  Future<void> deleteItem(String itemId) async {
    await itemBox.delete(itemId);
  }

  Future<void> updateItem(ItemModel item) async {
    await itemBox.put(item.id, item);
  }
}