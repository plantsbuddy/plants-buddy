import 'package:get_it/get_it.dart';

import '../data/appointment_service_impl.dart';
import '../domain/repositories/appointment_service.dart';
import '../domain/usecases/botanists_usecases.dart';

final sl = GetIt.instance;

void init() {
  _initUseCases();
  _initRepositories();
}

void _initUseCases() {
  sl.registerLazySingleton<ApproveAppointmentRequest>(() => ApproveAppointmentRequest(sl()));
  sl.registerLazySingleton<CancelAppointmentRequest>(() => CancelAppointmentRequest(sl()));
  sl.registerLazySingleton<GetBotanistReviewsStream>(() => GetBotanistReviewsStream(sl()));
  sl.registerLazySingleton<GetBotanists>(() => GetBotanists(sl()));
  sl.registerLazySingleton<GetReceivedAppointmentRequestsStream>(() => GetReceivedAppointmentRequestsStream(sl()));
  sl.registerLazySingleton<GetSentAppointmentRequestsStream>(() => GetSentAppointmentRequestsStream(sl()));
  sl.registerLazySingleton<PostBotanistReview>(() => PostBotanistReview(sl()));
  sl.registerLazySingleton<RejectAppointmentRequest>(() => RejectAppointmentRequest(sl()));
  sl.registerLazySingleton<SendAppointmentRequest>(() => SendAppointmentRequest(sl()));
  sl.registerLazySingleton<ReportBotanistReview>(() => ReportBotanistReview(sl()));
  sl.registerLazySingleton<ReportBotanist>(() => ReportBotanist(sl()));
  sl.registerLazySingleton<GetAvailableAppointmentSlots>(() => GetAvailableAppointmentSlots(sl()));
}

void _initRepositories() {
  sl.registerLazySingleton<AppointmentService>(() => AppointmentServiceImpl());
}
