import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/identification/domain/usecases/identification_usecases.dart';

import '../data/identification_service_impl.dart';
import '../domain/repositories/identification_service.dart';

final sl = GetIt.instance;

void init() {
  _initUseCases();
  _initRepositories();
}

void _initUseCases() {
  sl.registerLazySingleton<CaptureImageFromCamera>(() => CaptureImageFromCamera());
  sl.registerLazySingleton<DownloadImageFromUrl>(() => DownloadImageFromUrl());
  sl.registerLazySingleton<GetPlantDetails>(() => GetPlantDetails(sl()));
  sl.registerLazySingleton<PerformIdentification>(() => PerformIdentification());
  sl.registerLazySingleton<PickImageFromGallery>(() => PickImageFromGallery());
}

void _initRepositories() {
  sl.registerLazySingleton<IdentificationService>(() => IdentificationServiceImpl());
}
