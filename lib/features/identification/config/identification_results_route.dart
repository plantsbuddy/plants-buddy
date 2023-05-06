import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/identification/logic/identification_bloc/identification_bloc.dart';
import 'package:plants_buddy/features/identification/presentation/identify_screen.dart';
import 'package:plants_buddy/features/identification/presentation/identification_results_screen.dart';

import '../presentation/plant_details_screen.dart';

MaterialPageRoute route(Object? identificationBloc) {
  final sl = GetIt.instance;

  identificationBloc as IdentificationBloc;

  return MaterialPageRoute(
    builder: (_) {
      return BlocProvider.value(
        value: identificationBloc,
        child: IdentificationResultsScreen(),
      );
    },
  );
}
