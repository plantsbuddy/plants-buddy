import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/botanists/presentation/gardener/consult_botanists_screen.dart';
import 'package:plants_buddy/features/botanists/presentation/common/reviews_screen.dart';
import '../logic/botanist_bloc/botanist_bloc.dart';
import '../logic/botanists_bloc/botanists_bloc.dart';

MaterialPageRoute route() {
  final sl = GetIt.instance;

  return MaterialPageRoute(
    builder: (_) {
      return BlocProvider<BotanistBloc>(
        create: (_) => BotanistBloc(),
        child: ReviewsScreen(),
      );
    },
  );
}
