import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/authentication/logic/authentication_bloc.dart';
import 'package:plants_buddy/features/authentication/presentation/authentication_screen.dart';

MaterialPageRoute route() {
  final sl = GetIt.instance;

  return MaterialPageRoute(
    builder: (_) {
      return BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()),
        child: AuthenticationScreen(),
      );
    },
  );
}
