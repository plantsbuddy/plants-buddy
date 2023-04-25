import 'package:plants_buddy/features/collections/domain/entities/collection.dart';
import 'package:plants_buddy/features/collections/domain/repositories/collections_service.dart';

class AddPlantToCollection {
  final CollectionsService _collectionsService;

  AddPlantToCollection(this._collectionsService);

  Future<void> call({
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
  }) async {
    final Map<String, dynamic> plant = {
      'common_names': commonNames.split(',').map((name) => name.trim()).toList(),
      'scientific_name': scientificName.trim(),
      'leaf_color': leafColor.trim(),
      'genus': genus.trim(),
      'species': species.trim(),
      'family': family.trim(),
      'description': description.trim(),
      'light_conditions': lightConditions.trim(),
      'soil_drainage': soilDrainage.trim(),
    };

    return _collectionsService.addPlantToCollection(collection: collection, plant: plant);
  }
}
