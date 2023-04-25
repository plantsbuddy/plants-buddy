import 'package:plants_buddy/features/collections/domain/entities/collection.dart';
import 'package:plants_buddy/features/collections/domain/repositories/collections_service.dart';

class AddCollection {
  final CollectionsService _collectionsService;

  AddCollection(this._collectionsService);

  Future<void> call({required String name, required String cover}) async {
    final collection = Collection(cover: cover, name: name.trim());
    return _collectionsService.updateCollection(collection);
  }
}
