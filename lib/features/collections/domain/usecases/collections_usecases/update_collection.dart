import 'package:plants_buddy/features/collections/domain/entities/collection.dart';
import 'package:plants_buddy/features/collections/domain/repositories/collections_service.dart';

class UpdateCollection {
  final CollectionsService _collectionsService;

  UpdateCollection(this._collectionsService);

  Future<void> call({
    required String name,
    required String cover,
    required Collection? originalCollection,
  }) async {
    var collection = Collection(cover: cover, name: name.trim());

    if (originalCollection != null) {
      collection = collection.copyWith(id: originalCollection.id);
    }

    return _collectionsService.updateCollection(collection);
  }
}
