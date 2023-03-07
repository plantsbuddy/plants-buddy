import 'package:plants_buddy/features/authentication/domain/usecases/authentication_usecases.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/authentication/domain/usecases/authentication_usecases/send_email_verification_link.dart';

import '../data/authentication_date_source.dart';
import '../domain/repositories/authentication_repository.dart';

final sl = GetIt.instance;

void init() {
  _initUseCases();
  _initRepositories();
}

void _initUseCases() {
  sl.registerLazySingleton<SignupUser>(() => SignupUser(sl()));
  sl.registerLazySingleton<LoginUser>(() => LoginUser(sl()));
  sl.registerLazySingleton<UpdateUsername>(() => UpdateUsername(sl()));
  sl.registerLazySingleton<SendPasswordResetLink>(() => SendPasswordResetLink(sl()));
  sl.registerLazySingleton<SendEmailVerificationLink>(() => SendEmailVerificationLink(sl()));
}

void _initRepositories() {
  sl.registerLazySingleton<AuthenticationRepository>(() => AuthenticationDataSource());
}
