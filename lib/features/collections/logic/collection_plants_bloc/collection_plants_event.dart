part of 'collection_plants_bloc.dart';

@immutable
abstract class CollectionPlantsEvent {}

class CollectionPlantsInitializePlantsStream extends CollectionPlantsEvent {}

class CollectionPlantsDeletePlantPressed extends CollectionPlantsEvent {
  final CollectionPlant plant;

  CollectionPlantsDeletePlantPressed(this.plant);
}
