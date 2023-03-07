import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/reminders/data/reminders_data_source.dart';
import 'package:plants_buddy/features/reminders/domain/repositories/reminders_repository.dart';
import 'package:plants_buddy/features/reminders/domain/usecases/reminders_usecases.dart';

final sl = GetIt.instance;

void init() {
  _initUseCases();
  _initRepositories();
}

void _initUseCases() {
  sl.registerLazySingleton<AddReminder>(() => AddReminder(sl()));
  sl.registerLazySingleton<DeleteReminder>(() => DeleteReminder(sl()));
  sl.registerLazySingleton<UpdateReminder>(() => UpdateReminder(sl()));
  sl.registerLazySingleton<GetRemindersStream>(() => GetRemindersStream(sl()));
}

void _initRepositories() {
  sl.registerLazySingleton<RemindersRepository>(() => RemindersDataSource());
}
