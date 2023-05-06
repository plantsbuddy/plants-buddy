import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/identification/logic/identification_bloc/identification_bloc.dart';
import 'package:plants_buddy/features/identification/presentation/identify_screen.dart';

import '../presentation/history/history_identification_results_screen.dart';

MaterialPageRoute route(Object? data) {
  final sl = GetIt.instance;

  data as Map<String, dynamic>;

  return MaterialPageRoute(
    builder: (_) {
      return HistoryIdentificationResultsScreen(
        identificationType: data['identification_type'],
        results: data['results'],
      );
    },
  );
}
