import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/community/domain/entities/community_post.dart';
import 'package:plants_buddy/features/community/logic/add_community_post_bloc/add_community_post_bloc.dart';

import '../presentation/add_community_post_screen.dart';

MaterialPageRoute route(Object? post) {
  final sl = GetIt.instance;

  return MaterialPageRoute(
    builder: (_) {
      return BlocProvider<AddCommunityPostBloc>(
        create: (context) => AddCommunityPostBloc(post as CommunityPost?, sl(), sl()),
        child: AddCommunityPostScreen(),
      );
    },
  );
}
