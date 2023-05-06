import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/identification/logic/identification_bloc/identification_bloc.dart';
import 'package:plants_buddy/features/identification/presentation/identify_screen.dart';

import '../logic/identification_history_bloc/identification_history_bloc.dart';
import '../presentation/disease_details_screen.dart';
import '../presentation/history/identification_history_screen.dart';
import '../presentation/plant_details_screen.dart';

MaterialPageRoute route() {
  final sl = GetIt.instance;

  return MaterialPageRoute(
    builder: (_) {
      return BlocProvider<IdentificationHistoryBloc>(
        create: (context) => IdentificationHistoryBloc(sl())..add(IdentificationHistoryGetHistory()),
        child: IdentificationHistoryScreen(),
      );
    },
  );
}
