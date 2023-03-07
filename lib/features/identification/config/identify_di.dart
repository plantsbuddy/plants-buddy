import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  _initUseCases();
  _initRepositories();
}

void _initUseCases() {
  // sl.registerLazySingleton<SignupUser>(() => SignupUser(sl()));
  // sl.registerLazySingleton<LoginUser>(() => LoginUser(sl()));
  // sl.registerLazySingleton<UpdateUsername>(() => UpdateUsername(sl()));
  // sl.registerLazySingleton<SendPasswordResetLink>(() => SendPasswordResetLink(sl()));
  // sl.registerLazySingleton<SendEmailVerificationLink>(() => SendEmailVerificationLink(sl()));
}

void _initRepositories() {
  // sl.registerLazySingleton<AuthenticationRepository>(() => AuthenticationDataSource());
}
