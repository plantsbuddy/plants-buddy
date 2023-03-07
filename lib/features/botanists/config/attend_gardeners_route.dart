import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../logic/botanists_bloc/botanists_bloc.dart';
import '../presentation/botanist/attend_gardeners_screen.dart';

MaterialPageRoute route() {
  final sl = GetIt.instance;

  return MaterialPageRoute(
    builder: (_) {
      return BlocProvider<BotanistsBloc>(
        create: (_) => BotanistsBloc(),
        child: AttendGardenersScreen(),
      );
    },
  );
}
