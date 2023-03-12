import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/chat/data/chat_service_impl.dart';
import 'package:plants_buddy/features/chat/domain/repositories/chat_service.dart';
import 'package:plants_buddy/features/chat/domain/usecases/chat_usecases.dart';

final sl = GetIt.instance;

void init() {
  _initUseCases();
  _initRepositories();
}

void _initUseCases() {
  sl.registerLazySingleton<DeleteConversation>(() => DeleteConversation(sl()));
  sl.registerLazySingleton<DeleteMessage>(() => DeleteMessage(sl()));
  sl.registerLazySingleton<DownloadFile>(() => DownloadFile(sl()));
  sl.registerLazySingleton<GetConversationsStream>(() => GetConversationsStream(sl()));
  sl.registerLazySingleton<GetMessagesStream>(() => GetMessagesStream(sl()));
  sl.registerLazySingleton<SendMessage>(() => SendMessage(sl()));
}

void _initRepositories() {
  sl.registerLazySingleton<ChatService>(() => ChatServiceImpl());
}
