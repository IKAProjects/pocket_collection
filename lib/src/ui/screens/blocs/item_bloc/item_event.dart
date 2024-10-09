part of 'item_bloc.dart';

abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object?> get props => [];
}

class LoadItems extends ItemEvent {}

class AddItem extends ItemEvent {
  final ItemModel item;

  const AddItem(this.item);

  @override
  List<Object?> get props => [item];
}

class DeleteItem extends ItemEvent {
  final String itemId;

  const DeleteItem(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class UpdateItem extends ItemEvent {
  final ItemModel item;

  const UpdateItem(this.item);

  @override
  List<Object?> get props => [item];
}

class LoadItemDetailEvent extends ItemEvent {
  final String itemId;

  const LoadItemDetailEvent(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class SelectCategory extends ItemEvent {
  final String category;

  const SelectCategory(this.category);

  @override
  List<Object> get props => [category];
}

class SortItems extends ItemEvent {
  final String sortType;

  const SortItems(this.sortType);

  @override
  List<Object?> get props => [sortType];
}