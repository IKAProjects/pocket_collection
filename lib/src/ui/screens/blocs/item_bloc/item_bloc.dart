import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/item_repository.dart';
import '../../../../domain/models/item_model.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRepository itemRepository;
  List<ItemModel> _items = [];

  ItemBloc(this.itemRepository) : super(ItemInitial()) {
    on<LoadItems>(_onLoadItems);
    on<AddItem>(_onAddItem);
    on<DeleteItem>(_onDeleteItem);
    on<UpdateItem>(_onUpdateItem);
    on<LoadItemDetailEvent>(_loadItemDetail);
    on<SelectCategory>(_onSelectCategory);
    on<SortItems>(_onSortItems);
  }

  Future<void> _loadItemDetail(
      LoadItemDetailEvent event,
      Emitter<ItemState> emit,
      ) async {
    try {
      final item = await itemRepository.getItemById(event.itemId);
      if (item != null) {
        emit(ItemDetailLoaded(item));
      } else {
        emit(ItemError('Item not found'));
      }
    } catch (e) {
      emit(ItemError('Failed to load item: ${e.toString()}'));
    }
  }

  Future<void> _onLoadItems(
      LoadItems event,
      Emitter<ItemState> emit,
      ) async {
    emit(ItemLoading());
    try {
      _items = await itemRepository.getAllItems();
      emit(ItemsLoaded(_items));
    } catch (e) {
      emit(ItemError('Failed to load items: ${e.toString()}'));
    }
  }

  Future<void> _onAddItem(
      AddItem event,
      Emitter<ItemState> emit,
      ) async {
    emit(ItemLoading());
    try {
      await itemRepository.addItem(event.item);
      await _fetchItems(emit);
    } catch (e) {
      emit(ItemError('Failed to add item: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteItem(
      DeleteItem event,
      Emitter<ItemState> emit,
      ) async {
    emit(ItemLoading());
    try {
      await itemRepository.deleteItem(event.itemId);
      await _fetchItems(emit);
    } catch (e) {
      emit(ItemError('Failed to delete item: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateItem(
      UpdateItem event,
      Emitter<ItemState> emit,
      ) async {
    emit(ItemLoading());
    try {
      await itemRepository.updateItem(event.item);
      await _fetchItems(emit);
    } catch (e) {
      emit(ItemError('Failed to update item: ${e.toString()}'));
    }
  }

  Future<void> _fetchItems(Emitter<ItemState> emit) async {
    _items = await itemRepository.getAllItems();
    emit(ItemsLoaded(_items));
  }

  void _onSelectCategory(SelectCategory event, Emitter<ItemState> emit) {
    emit(CategorySelected(event.category));
  }

  void _onSortItems(SortItems event, Emitter<ItemState> emit) {
    if (_items.isEmpty) {
      emit(ItemsLoaded(_items));
      return;
    }

    switch (event.sortType) {
      case 'newToOld':
        _items.sort((a, b) => _compareDates(b.createdDate, a.createdDate));
        break;
      case 'oldToNew':
        _items.sort((a, b) => _compareDates(a.createdDate, b.createdDate));
        break;
      case 'A-Z':
        _items.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Z-A':
        _items.sort((a, b) => b.name.compareTo(a.name));
        break;
      case 'HighToLow':
        _items.sort((a, b) => (b.price ?? 0).compareTo(a.price ?? 0));
        break;
      case 'LowToHigh':
        _items.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
        break;
    }

    emit(ItemsLoaded(_items));
  }

  int _compareDates(DateTime? dateA, DateTime? dateB) {
    if (dateA == null && dateB == null) {
      return 0;
    } else if (dateA == null) {
      return -1;
    } else if (dateB == null) {
      return 1;
    }
    return dateA.compareTo(dateB);
  }
}