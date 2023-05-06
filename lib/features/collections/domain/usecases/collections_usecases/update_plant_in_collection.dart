import 'dart:io';

import 'package:plants_buddy/features/collections/domain/entities/collection.dart';
import 'package:plants_buddy/features/collections/domain/entities/collection_plant.dart';
import 'package:plants_buddy/features/collections/domain/repositories/collections_service.dart';

class UpdatePlantInCollection {
  final CollectionsService _collectionsService;

  UpdatePlantInCollection(this._collectionsService);

  Future<void> call({
    required String imagePath,
    required Collection collection,
    required String commonNames,
    required String scientificName,
    required String leafColor,
    required String genus,
    required String species,
    required String family,
    required String description,
    required String lightConditions,
    required String soilDrainage,
    required CollectionPlant? originalPlant,
  }) async {
    final Map<String, dynamic> plantDetails = {
      'website': '1',
      'images': [imagePath],
      'common_names': commonNames.split(',').map((name) => name.trim()).toList(),
      'scientific_name': scientificName.trim(),
      'leaf_color': leafColor.trim(),
      'genus': genus.trim(),
      'species': species.trim(),
      'family': family.trim(),
      'description': description.trim(),
      'light': lightConditions.trim(),
      'soil_drainage': [soilDrainage.trim()],
    };

    var plant = CollectionPlant(details: plantDetails);

    if (originalPlant != null) {
      plant = plant.copyWith(id: originalPlant.id);
    }

    return _collectionsService.updatePlantInCollection(collection: collection, plant: plant);
  }
}
