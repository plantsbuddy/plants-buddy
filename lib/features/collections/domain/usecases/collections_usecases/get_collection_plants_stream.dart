import 'package:plants_buddy/features/collections/domain/entities/collection.dart';
import 'package:plants_buddy/features/collections/domain/repositories/collections_service.dart';

import '../../entities/collection_plant.dart';

class GetCollectionPlantsStream {
  final CollectionsService _collectionsService;

  GetCollectionPlantsStream(this._collectionsService);

  Future<Stream<List<CollectionPlant>>> call(Collection collection) async {
    return _collectionsService.getCollectionPlantsStream(collection);
  }
}
