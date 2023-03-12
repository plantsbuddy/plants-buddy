import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/authentication/logic/authentication_bloc.dart';
import 'package:plants_buddy/features/botanists/logic/botanist_appointment_bloc/botanist_appointment_bloc.dart';
import 'package:plants_buddy/features/chat/logic/chat_bloc.dart';
import '../../authentication/domain/entities/user.dart';
import '../presentation/botanist/attend_gardeners_screen.dart';

MaterialPageRoute route(Object? authenticationBloc) {
  final sl = GetIt.instance;

  authenticationBloc as AuthenticationBloc;

  return MaterialPageRoute(
    builder: (_) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<BotanistAppointmentBloc>(
            create: (_) => BotanistAppointmentBloc(sl(), sl(), sl()),
          ),
          BlocProvider.value(value: authenticationBloc),
          BlocProvider<ChatBloc>(
            create: (_) => ChatBloc(sl(), sl(), sl(), sl(), sl(), sl())..add(ChatInitializeConversationsStream(authenticationBloc.state.currentUser!)),
          ),
        ],
        child: AttendGardenersScreen(),
      );
    },
  );
}
