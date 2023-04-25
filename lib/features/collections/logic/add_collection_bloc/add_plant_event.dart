part of 'add_plant_bloc.dart';

@immutable
abstract class AddPlantEvent {}

class AddPlantSubmitButtonPressed extends AddPlantEvent {
  final String commonNames,
      scientificName,
      leafColor,
      genus,
      species,
      family,
      description,
      lightConditions,
      soilDrainage;

  AddPlantSubmitButtonPressed({
    required this.commonNames,
    required this.scientificName,
    required this.leafColor,
    required this.genus,
    required this.species,
    required this.family,
    required this.description,
    required this.lightConditions,
    required this.soilDrainage,
  });
}
