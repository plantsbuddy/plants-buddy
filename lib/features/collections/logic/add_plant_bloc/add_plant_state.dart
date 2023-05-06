part of '../add_plant_bloc/add_plant_bloc.dart';

@immutable
class AddPlantState extends Equatable {
  final String commonNames,
      scientificName,
      leafColor,
      genus,
      species,
      family,
      description,
      lightConditions,
      soilDrainage;
  final Collection collection;
  final CollectionPlant? originalPlant;

  AddPlantState({
    required this.commonNames,
    required this.scientificName,
    required this.leafColor,
    required this.genus,
    required this.species,
    required this.family,
    required this.description,
    required this.lightConditions,
    required this.soilDrainage,
    required this.originalPlant,
    required this.collection,
  });

  AddPlantState.create(this.collection)
      : commonNames = '',
        scientificName = '',
        leafColor = '',
        genus = '',
        species = '',
        family = '',
        description = '',
        soilDrainage = '',
        lightConditions = '',
        originalPlant = null;

  AddPlantState.update({required this.originalPlant, required this.collection})
      : commonNames = (originalPlant!.details['common_names']).join(', '),
        scientificName = originalPlant.details['scientific_name'],
        leafColor = originalPlant.details['leaf_color'],
        genus = originalPlant.details['genus'],
        species = originalPlant.details['species'],
        family = originalPlant.details['family'],
        description = originalPlant.details['description'],
        soilDrainage = (originalPlant.details['soil_drainage']).join(', '),
        lightConditions = originalPlant.details['light'];

  @override
  List<Object?> get props => [
        collection,
        commonNames,
        scientificName,
        leafColor,
        genus,
        species,
        family,
        description,
        soilDrainage,
        lightConditions,
        originalPlant,
      ];
}
