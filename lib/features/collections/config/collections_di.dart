import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/collections/domain/repositories/collections_service.dart';
import 'package:plants_buddy/features/collections/domain/usecases/collections_usecases.dart';

import '../data/collections_service_impl.dart';

final sl = GetIt.instance;

void init() {
  _initUseCases();
  _initRepositories();
}

void _initUseCases() {
  sl.registerLazySingleton<AddCollection>(() => AddCollection(sl()));
  sl.registerLazySingleton<DeleteCollection>(() => DeleteCollection(sl()));
  sl.registerLazySingleton<GetCollectionsStream>(() => GetCollectionsStream(sl()));
  sl.registerLazySingleton<GetCollectionPlantsStream>(() => GetCollectionPlantsStream(sl()));
  sl.registerLazySingleton<AddPlantToCollection>(() => AddPlantToCollection(sl()));
}

void _initRepositories() {
  sl.registerLazySingleton<CollectionsService>(() => CollectionsServiceImpl());
}
