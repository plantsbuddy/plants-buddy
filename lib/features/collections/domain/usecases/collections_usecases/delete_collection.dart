import 'package:plants_buddy/features/collections/domain/entities/collection.dart';
import 'package:plants_buddy/features/collections/domain/repositories/collections_service.dart';

class DeleteCollection {
  final CollectionsService _collectionsService;

  DeleteCollection(this._collectionsService);

  Future<void> call(Collection collection) async {
    return _collectionsService.deleteCollection(collection);
  }
}
