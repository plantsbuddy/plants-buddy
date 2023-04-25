part of 'collection_plants_bloc.dart';

enum CollectionPlantsStatus { loading, loaded }

@immutable
class CollectionPlantsState extends Equatable {
  final Collection collection;
  final CollectionPlantsStatus status;
  final List<Map<String, dynamic>> plants;

  CollectionPlantsState.initial(this.collection)
      : status = CollectionPlantsStatus.loaded,
        plants = [];

  CollectionPlantsState({required this.plants, required this.status, required this.collection});

  CollectionPlantsState copyWith({
    List<Map<String, dynamic>>? plants,
    CollectionPlantsStatus? status,
  }) =>
      CollectionPlantsState(
        plants: plants ?? this.plants,
        status: status ?? this.status,
        collection: collection,
      );

  @override
  List<Object?> get props => [status, plants, collection];
}
