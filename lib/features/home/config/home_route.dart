import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/community/logic/community_bloc/community_bloc.dart';
import 'package:plants_buddy/features/home/logic/home_cubit.dart';
import 'package:plants_buddy/features/home/presentation/home_screen.dart';
import 'package:plants_buddy/features/reminders/logic/reminders_bloc/reminders_bloc.dart';

MaterialPageRoute route() {
  final sl = GetIt.instance;

  return MaterialPageRoute(
    builder: (_) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<HomeCubit>(
            create: (context) => HomeCubit(),
          ),
          BlocProvider<CommunityBloc>(
            create: (context) => CommunityBloc(sl(), sl(), sl(), sl())..add(CommunityPostsStreamInitialize()),
          ),
          BlocProvider<RemindersBloc>(
            create: (context) => RemindersBloc(sl(), sl())..add(RemindersStreamInitialize()),
          ),
        ],
        child: HomeScreen(),
      );
    },
  );
}
