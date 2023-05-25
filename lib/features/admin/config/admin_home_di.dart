import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/admin/data/admin_service_impl.dart';
import 'package:plants_buddy/features/admin/domain/repositories/admin_service.dart';
import 'package:plants_buddy/features/admin/domain/usecases/admin_usecases.dart';

final sl = GetIt.instance;

void init() {
  _initUseCases();
  _initRepositories();
}

void _initUseCases() {
  sl.registerLazySingleton<BlockUser>(() => BlockUser(sl()));
  sl.registerLazySingleton<DeleteReportedComment>(() => DeleteReportedComment(sl()));
  sl.registerLazySingleton<DeleteReportedPost>(() => DeleteReportedPost(sl()));
  sl.registerLazySingleton<DeleteReportedBotanistRating>(() => DeleteReportedBotanistRating(sl()));
  sl.registerLazySingleton<GetReportedCommentsStream>(() => GetReportedCommentsStream(sl()));
  sl.registerLazySingleton<GetReportedPostsStream>(() => GetReportedPostsStream(sl()));
  sl.registerLazySingleton<GetReportedRatingsStream>(() => GetReportedRatingsStream(sl()));
  sl.registerLazySingleton<GetReportedBotanistsStream>(() => GetReportedBotanistsStream(sl()));
  sl.registerLazySingleton<GetBlockedUsersStream>(() => GetBlockedUsersStream(sl()));
  sl.registerLazySingleton<GetReports>(() => GetReports(sl()));
  sl.registerLazySingleton<IgnoreReport>(() => IgnoreReport(sl()));
  sl.registerLazySingleton<UnblockUser>(() => UnblockUser(sl()));
}

void _initRepositories() {
  sl.registerLazySingleton<AdminService>(() => AdminServiceImpl());
}
