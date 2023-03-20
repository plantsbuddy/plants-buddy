import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/payment/data/payment_service_impl.dart';
import 'package:plants_buddy/features/payment/domain/repositories/payment_service.dart';
import 'package:plants_buddy/features/payment/domain/usecases/payment_usecases.dart';
final sl = GetIt.instance;

void init() {
  _initUseCases();
  _initRepositories();
}

void _initUseCases() {
  sl.registerLazySingleton<AddCardDetailsToStripe>(() => AddCardDetailsToStripe(sl()));
  sl.registerLazySingleton<CheckGardenerAccountBalance>(() => CheckGardenerAccountBalance(sl()));
  sl.registerLazySingleton<GetPaymentDetailsStream>(() => GetPaymentDetailsStream(sl()));
  sl.registerLazySingleton<GetTransactionHistory>(() => GetTransactionHistory(sl()));
  sl.registerLazySingleton<PerformConsultationTransaction>(() => PerformConsultationTransaction(sl()));
}

void _initRepositories() {
  sl.registerLazySingleton<PaymentService>(() => PaymentServiceImpl());
}
