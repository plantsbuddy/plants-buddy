import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/community/logic/add_community_post_bloc/add_community_post_bloc.dart';

import '../presentation/add_community_post_screen.dart';

MaterialPageRoute route(Object? data) {
  final sl = GetIt.instance;

  data as Map<String, dynamic>?;

  final bloc = AddCommunityPostBloc(data?['post'], sl(), sl());

  if (data != null && data.containsKey('image')) {
    bloc.add(AddCommunityPostImageChanged(data['image']));
  }

  return MaterialPageRoute(
    builder: (_) {
      return BlocProvider<AddCommunityPostBloc>(
        create: (_) => bloc,
        child: AddCommunityPostScreen(),
      );
    },
  );
}
