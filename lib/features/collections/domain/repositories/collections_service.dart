import 'package:plants_buddy/features/collections/domain/entities/collection.dart';

import '../entities/collection_plant.dart';

abstract class CollectionsService {
  Future<void> updateCollection(Collection collection);

  Future<void> deleteCollection(Collection collection);

  Future<void> deletePlantFromCollection({required CollectionPlant plant, required Collection collection});

  Future<Stream<List<Collection>>> get collectionsStream;

  Future<Stream<List<CollectionPlant>>> getCollectionPlantsStream(Collection collection);

  Future<void> updatePlantInCollection({required Collection collection, required CollectionPlant plant});
}
