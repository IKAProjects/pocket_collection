part of 'collection_bloc.dart';

sealed class CollectionEvent extends Equatable {
  const CollectionEvent();

  @override
  List<Object?> get props => [];
}

class LoadCollections extends CollectionEvent {
  const LoadCollections();
}

class AddCollection extends CollectionEvent {
  final CollectionModel collection;

  const AddCollection(this.collection);

  @override
  List<Object?> get props => [collection];
}

class DeleteCollection extends CollectionEvent {
  final String collectionId;

  const DeleteCollection(this.collectionId);

  @override
  List<Object?> get props => [collectionId];
}

class UpdateCollection extends CollectionEvent {
  final CollectionModel collection;

  const UpdateCollection(this.collection);

  @override
  List<Object?> get props => [collection];
}

final class LoadCollectionDetailEvent extends CollectionEvent {
  final String collectionKey;

  const LoadCollectionDetailEvent({required this.collectionKey});

  @override
  List<Object?> get props => [collectionKey];
}