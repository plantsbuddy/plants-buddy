import 'package:plants_buddy/features/collections/domain/entities/collection.dart';
import 'package:plants_buddy/features/collections/domain/repositories/collections_service.dart';

import '../../entities/collection_plant.dart';

class DeletePlantFromCollection {
  final CollectionsService _collectionsService;

  DeletePlantFromCollection(this._collectionsService);

  Future<void> call({required CollectionPlant plant, required Collection collection}) async {
    return _collectionsService.deletePlantFromCollection(plant: plant, collection: collection);
  }
}
