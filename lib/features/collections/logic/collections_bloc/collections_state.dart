part of 'collections_bloc.dart';

enum CollectionsStatus { loading, loaded }

@immutable
class CollectionsState extends Equatable {
  final CollectionsStatus status;
  final List<Collection> collections;

  CollectionsState.initial()
      : status = CollectionsStatus.loading,
        collections = [];

  CollectionsState({required this.collections, required this.status});

  CollectionsState copyWith({
    List<Collection>? collections,
    CollectionsStatus? status,
  }) =>
      CollectionsState(
        collections: collections ?? this.collections,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [status, collections];
}
