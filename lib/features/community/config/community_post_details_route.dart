import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/community/presentation/community_post_details_screen.dart';

import '../domain/entities/community_post.dart';
import '../logic/community_post_bloc/community_post_bloc.dart';
import '../presentation/add_community_post_screen.dart';

MaterialPageRoute route(Object? post) {
  final sl = GetIt.instance;

  post as CommunityPost;
  return MaterialPageRoute(
    builder: (_) {
      return BlocProvider<CommunityPostBloc>(
        create: (context) => CommunityPostBloc(post.id!, sl(), sl())..add(CommunityPostCommentsStreamInitialize()),
        child: CommunityPostDetailsScreen(post),
      );
    },
  );
}
