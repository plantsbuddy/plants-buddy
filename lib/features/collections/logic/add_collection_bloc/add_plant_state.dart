part of 'add_plant_bloc.dart';

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
  final Map<String, dynamic>? originalPlant;

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
      : commonNames = (originalPlant!['common_names'] as List<String>).join(', '),
        scientificName = originalPlant['scientific_name'],
        leafColor = originalPlant['leaf_color'],
        genus = originalPlant['genus'],
        species = originalPlant['species'],
        family = originalPlant['family'],
        description = originalPlant['description'],
        soilDrainage = originalPlant['soil_drainage'],
        lightConditions = originalPlant['light_conditions'];

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
