import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../logic/admin_bloc.dart';
import '../presentation/screens/reported_botanists_screen.dart';


MaterialPageRoute route(Object? adminBloc) {
  final sl = GetIt.instance;

  adminBloc as AdminBloc;

  adminBloc.add(AdminInitializeReportedBotanistsStream());

  return MaterialPageRoute(
    builder: (_) {
      return BlocProvider.value(
        value: adminBloc,
        child: ReportedBotanistsScreen(),
      );
    },
  );
}
