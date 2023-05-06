import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/identification/logic/identification_bloc/identification_bloc.dart';
import 'package:plants_buddy/features/identification/presentation/identify_screen.dart';

MaterialPageRoute route(Object? indentificationType) {
  final sl = GetIt.instance;

  indentificationType as IdentificationType;

  return MaterialPageRoute(
    builder: (_) {
      return BlocProvider<IdentificationBloc>(
        create: (_) => IdentificationBloc(identificationType: indentificationType, sl(), sl(), sl(), sl(), sl()),
        child: IdentifyScreen(),
      );
    },
  );
}
