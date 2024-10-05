import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/collection_repository.dart';
import '../../../../domain/models/collection_model.dart';

part 'collection_event.dart';
part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  final CollectionRepository collectionRepository;

  CollectionBloc(this.collectionRepository) : super(CollectionInitial()) {
    on<LoadCollections>(_onLoadCollections);
    on<AddCollection>(_onAddCollection);
    on<DeleteCollection>(_onDeleteCollection);
    on<UpdateCollection>(_onUpdateCollection);
    on<LoadCollectionDetailEvent>(_loadCollectionDetail);
  }

  Future<void> _loadCollectionDetail(
      LoadCollectionDetailEvent event,
      Emitter<CollectionState> emit,
      ) async {
    try {
      final collection = await collectionRepository.getCollectionById(event.collectionKey);
      emit(CollectionDetailState(collectionModel: collection!));
    } catch (e) {
      emit(CollectionError(e.toString()));
    }
  }

  Future<void> _onLoadCollections(
      LoadCollections event,
      Emitter<CollectionState> emit,
      ) async {
    emit(CollectionLoading());
    try {
      final collections = await collectionRepository.getAllCollections();
      emit(CollectionLoaded(collections));
    } catch (e) {
      emit(CollectionError(e.toString()));
    }
  }

  Future<void> _onAddCollection(
      AddCollection event,
      Emitter<CollectionState> emit,
      ) async {
    emit(CollectionLoading());
    try {
      await collectionRepository.addCollection(event.collection);
      final collections = await collectionRepository.getAllCollections();
      emit(CollectionLoaded(collections));
    } catch (e) {
      emit(CollectionError(e.toString()));
    }
  }

  Future<void> _onDeleteCollection(
      DeleteCollection event,
      Emitter<CollectionState> emit,
      ) async {
    emit(CollectionLoading());
    try {
      await collectionRepository.deleteCollection(event.collectionId);
      final collections = await collectionRepository.getAllCollections();
      emit(CollectionLoaded(collections));
    } catch (e) {
      emit(CollectionError(e.toString()));
    }
  }

  Future<void> _onUpdateCollection(
      UpdateCollection event,
      Emitter<CollectionState> emit,
      ) async {
    emit(CollectionLoading());
    try {
      await collectionRepository.updateCollection(event.collection);
      final collections = await collectionRepository.getAllCollections();
      emit(CollectionLoaded(collections));
    } catch (e) {
      emit(CollectionError(e.toString()));
    }
  }
}