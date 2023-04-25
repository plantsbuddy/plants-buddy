import 'package:plants_buddy/features/collections/domain/entities/collection.dart';

abstract class CollectionsService {
  Future<void> updateCollection(Collection collection);

  Future<void> deleteCollection(Collection collection);

  Future<Stream<List<Collection>>> get collectionsStream;

  Future<Stream<List<Map<String, dynamic>>>> getCollectionPlantsStream(Collection collection);

  Future<void> addPlantToCollection({required Collection collection, required Map<String, dynamic> plant});
}
