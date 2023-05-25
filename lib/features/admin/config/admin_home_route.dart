import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../logic/admin_bloc.dart';
import '../presentation/admin_home_screen.dart';

MaterialPageRoute route() {
  final sl = GetIt.instance;

  return MaterialPageRoute(
    builder: (_) {
      return BlocProvider<AdminBloc>(
        create: (context) => AdminBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(),sl()),
        child: AdminHomeScreen(),
      );
    },
  );
}
