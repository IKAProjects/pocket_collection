part of 'item_bloc.dart';

abstract class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object?> get props => [];
}

class ItemInitial extends ItemState {}

class ItemLoading extends ItemState {}

class ItemsLoaded extends ItemState {
  final List<ItemModel> items;

  const ItemsLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class ItemDetailLoaded extends ItemState {
  final ItemModel item;

  const ItemDetailLoaded(this.item);

  @override
  List<Object?> get props => [item];
}

class ItemError extends ItemState {
  final String message;

  const ItemError(this.message);

  @override
  List<Object?> get props => [message];
}

class CategorySelected extends ItemState {
  final String selectedCategory;

  const CategorySelected(this.selectedCategory);

  @override
  List<Object> get props => [selectedCategory];
}