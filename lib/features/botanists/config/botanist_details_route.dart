import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/authentication/domain/entities/botanist.dart';
import 'package:plants_buddy/features/authentication/logic/authentication_bloc.dart';
import 'package:plants_buddy/features/chat/logic/chat_bloc.dart';
import '../logic/gardener_appointment_bloc/gardener_appointment_bloc.dart';
import '../presentation/gardener/botanist_details_screen.dart';

MaterialPageRoute route(Object? arguments) {
  final sl = GetIt.instance;

  arguments as Map<String, dynamic>;

  final gardenerAppointmentBloc = arguments['gardener_appointment_bloc'] as GardenerAppointmentBloc;
  final botanist = arguments['botanist'] as Botanist;
  final chatBloc = arguments['chat_bloc'] as ChatBloc;
  final authenticationBloc = arguments['authentication_bloc'] as AuthenticationBloc;

  return MaterialPageRoute(
    builder: (_) {
      return MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: gardenerAppointmentBloc,
          ),
          BlocProvider.value(
            value: chatBloc,
          ),
          BlocProvider.value(
            value: authenticationBloc,
          ),
        ],
        child: BotanistDetailsScreen(botanist),
      );
    },
  );
}
