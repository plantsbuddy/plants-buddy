import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/reminders/data/reminders_data_source.dart';
import 'package:plants_buddy/features/reminders/domain/repositories/reminders_repository.dart';
import 'package:plants_buddy/features/reminders/domain/usecases/reminders_usecases.dart';
import 'package:plants_buddy/features/suggestions/domain/repositories/suggestions_service.dart';

import '../data/suggestions_service_impl.dart';
import '../domain/usecases/suggestions_usecases.dart';

final sl = GetIt.instance;

void init() {
  _initUseCases();
  _initRepositories();
}

void _initUseCases() {
  sl.registerLazySingleton<GetPlantationGuides>(() => GetPlantationGuides(sl()));
  sl.registerLazySingleton<GetRandomPlantationSuggestion>(() => GetRandomPlantationSuggestion(sl()));
  sl.registerLazySingleton<GetWeatherBasedSuggestions>(() => GetWeatherBasedSuggestions(sl()));
  sl.registerLazySingleton<GetWeatherBasedPlantSuggestions>(() => GetWeatherBasedPlantSuggestions(sl()));
  sl.registerLazySingleton<GetWeatherData>(() => GetWeatherData(sl()));
}

void _initRepositories() {
  sl.registerLazySingleton<SuggestionsService>(() => SuggestionsServiceImpl());
}
