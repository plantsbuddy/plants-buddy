import 'package:get_it/get_it.dart';
import 'package:flutter/services.dart';
import 'package:dialogflow_grpc/dialogflow_grpc.dart';
import 'package:plants_buddy/features/chatbot/data/chatbot_service_impl.dart';
import 'package:plants_buddy/features/chatbot/domain/repositories/chatbot_service.dart';

import '../domain/usecases/chatbot_usecases.dart';

final sl = GetIt.instance;

Future<void> init() async {
  _initUseCases();
  await _initRepositories();
}

Future<void> _initUseCases() async {
  sl.registerLazySingleton<GetChatbotResponse>(() => GetChatbotResponse(sl()));
  // sl.registerLazySingleton<LoginUser>(() => LoginUser(sl()));
  // sl.registerLazySingleton<UpdateUsername>(() => UpdateUsername(sl()));
  // sl.registerLazySingleton<SendPasswordResetLink>(() => SendPasswordResetLink(sl()));
  // sl.registerLazySingleton<SendEmailVerificationLink>(() => SendEmailVerificationLink(sl()));
}

Future<void> _initRepositories() async {
  final serviceAccount = ServiceAccount.fromString(
    await rootBundle.loadString('assets/dialogflow_credentials.json'),
  );

  // dialogflow setup
  final dialogflow = DialogflowGrpcV2Beta1.viaServiceAccount(serviceAccount);

  sl.registerLazySingleton<ChatbotService>(() => ChatbotServiceImpl(dialogflow));
}
