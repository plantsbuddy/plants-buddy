import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/botanists/presentation/gardener/consult_botanists_screen.dart';
import '../logic/botanists_bloc/botanists_bloc.dart';

MaterialPageRoute route() {
  final sl = GetIt.instance;

  return MaterialPageRoute(
    builder: (_) {
      return BlocProvider<BotanistsBloc>(
        create: (_) => BotanistsBloc(),
        child: ConsultBotanistsScreen(),
      );
    },
  );
}
