import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/item_repository.dart';
import '../../../../domain/models/item_model.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRepository itemRepository;

  ItemBloc(this.itemRepository) : super(ItemInitial()) {
    on<LoadItems>(_onLoadItems);
    on<AddItem>(_onAddItem);
    on<DeleteItem>(_onDeleteItem);
    on<UpdateItem>(_onUpdateItem);
    on<LoadItemDetailEvent>(_loadItemDetail);
    on<SelectCategory>(_onSelectCategory);
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
      emit(ItemError(e.toString()));
    }
  }

  Future<void> _onLoadItems(
      LoadItems event,
      Emitter<ItemState> emit,
      ) async {
    emit(ItemLoading());
    try {
      final items = await itemRepository.getAllItems();
      emit(ItemsLoaded(items));
    } catch (e) {
      emit(ItemError(e.toString()));
    }
  }

  Future<void> _onAddItem(
      AddItem event,
      Emitter<ItemState> emit,
      ) async {
    emit(ItemLoading());
    try {
      await itemRepository.addItem(event.item);
      final items = await itemRepository.getAllItems();
      emit(ItemsLoaded(items));
    } catch (e) {
      emit(ItemError(e.toString()));
    }
  }

  Future<void> _onDeleteItem(
      DeleteItem event,
      Emitter<ItemState> emit,
      ) async {
    emit(ItemLoading());
    try {
      await itemRepository.deleteItem(event.itemId);
      final items = await itemRepository.getAllItems();
      emit(ItemsLoaded(items));
    } catch (e) {
      emit(ItemError(e.toString()));
    }
  }

  Future<void> _onUpdateItem(
      UpdateItem event,
      Emitter<ItemState> emit,
      ) async {
    emit(ItemLoading());
    try {
      await itemRepository.updateItem(event.item);
      final items = await itemRepository.getAllItems();
      emit(ItemsLoaded(items));
    } catch (e) {
      emit(ItemError(e.toString()));
    }
  }

  void _onSelectCategory(SelectCategory event, Emitter<ItemState> emit) {
    emit(CategorySelected(event.category));
  }
}