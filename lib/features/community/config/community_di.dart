import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/community/data/community_data_source.dart';
import 'package:plants_buddy/features/community/domain/repositories/community_repository.dart';
import 'package:plants_buddy/features/community/domain/usecases/community_usecases.dart';

final sl = GetIt.instance;

void init() {
  _initUseCases();
  _initRepositories();
}

void _initUseCases() {
  sl.registerLazySingleton<AddComment>(() => AddComment(sl()));
  sl.registerLazySingleton<AddCommunityPost>(() => AddCommunityPost(sl()));
  sl.registerLazySingleton<DeleteComment>(() => DeleteComment(sl()));
  sl.registerLazySingleton<DeleteCommunityPost>(() => DeleteCommunityPost(sl()));
  sl.registerLazySingleton<GetCommunityPostsStream>(() => GetCommunityPostsStream(sl()));
  sl.registerLazySingleton<GetPostCommentsStream>(() => GetPostCommentsStream(sl()));
  sl.registerLazySingleton<GetMyCommunityPosts>(() => GetMyCommunityPosts(sl()));
  sl.registerLazySingleton<SearchCommunityPosts>(() => SearchCommunityPosts(sl()));
  sl.registerLazySingleton<UpdateCommunityPost>(() => UpdateCommunityPost(sl()));
}

void _initRepositories() {
  sl.registerLazySingleton<CommunityRepository>(() => CommunityDataSource());
}
