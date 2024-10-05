part of 'collection_bloc.dart';

sealed class CollectionState extends Equatable {
  const CollectionState();

  @override
  List<Object?> get props => [];
}

final class CollectionInitial extends CollectionState {}

final class CollectionLoading extends CollectionState {}

final class CollectionLoaded extends CollectionState {
  final List<CollectionModel> collections;

  const CollectionLoaded(this.collections);

  @override
  List<Object?> get props => [collections];
}

final class CollectionError extends CollectionState {
  final String message;

  const CollectionError(this.message);

  @override
  List<Object?> get props => [message];
}

final class CollectionAdded extends CollectionState {
  final CollectionModel collection;

  const CollectionAdded(this.collection);

  @override
  List<Object?> get props => [collection];
}

final class CollectionDeleted extends CollectionState {
  final String collectionId;

  const CollectionDeleted(this.collectionId);

  @override
  List<Object?> get props => [collectionId];
}

final class CollectionUpdated extends CollectionState {
  final CollectionModel collection;

  const CollectionUpdated(this.collection);

  @override
  List<Object?> get props => [collection];
}

final class CollectionDetailState extends CollectionState {
  const CollectionDetailState({required this.collectionModel});

  final CollectionModel collectionModel;

  @override
  List<Object?> get props => [collectionModel];
}