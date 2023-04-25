import 'package:plants_buddy/features/collections/domain/entities/collection.dart';
import 'package:plants_buddy/features/collections/domain/repositories/collections_service.dart';

class GetCollectionsStream {
  final CollectionsService _collectionsService;

  GetCollectionsStream(this._collectionsService);

  Future<Stream<List<Collection>>> call() async {
    return _collectionsService.collectionsStream;
  }
}
