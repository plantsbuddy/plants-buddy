import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/botanists/presentation/gardener/consult_botanists_screen.dart';
import 'package:plants_buddy/features/botanists/presentation/common/reviews_screen.dart';

import '../logic/gardener_appointment_bloc/gardener_appointment_bloc.dart';

MaterialPageRoute route(Object? gardenerAppointmentBloc) {
  final sl = GetIt.instance;

  gardenerAppointmentBloc as GardenerAppointmentBloc;

  return MaterialPageRoute(
    builder: (_) {
      return BlocProvider.value(
        value: gardenerAppointmentBloc,
        child: ReviewsScreen(),
      );
    },
  );
}
