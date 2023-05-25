import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../logic/admin_bloc.dart';
import '../presentation/screens/blocked_users_screen.dart';


MaterialPageRoute route(Object? adminBloc) {
  final sl = GetIt.instance;

  adminBloc as AdminBloc;

  adminBloc.add(AdminInitializeBlockedUsersStream());

  return MaterialPageRoute(
    builder: (_) {
      return BlocProvider.value(
        value: adminBloc,
        child: BlockedUsersScreen(),
      );
    },
  );
}
