import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/botanists/presentation/gardener/consult_botanists_screen.dart';
import 'package:plants_buddy/features/chat/logic/chat_bloc.dart';

import '../../authentication/domain/entities/user.dart';
import '../../authentication/logic/authentication_bloc.dart';
import '../../payment/logic/payment_bloc.dart';
import '../logic/gardener_appointment_bloc/gardener_appointment_bloc.dart';

MaterialPageRoute route(Object? authenticationBloc) {
  final sl = GetIt.instance;

  authenticationBloc as AuthenticationBloc;

  return MaterialPageRoute(
    builder: (_) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<GardenerAppointmentBloc>(
            create: (_) => GardenerAppointmentBloc(sl(), sl(), sl(), sl())
              ..add(GardenerInitializeSentAppointmentRequestsStream()),
          ),
          BlocProvider.value(value: authenticationBloc),
          BlocProvider<ChatBloc>(
            create: (_) => ChatBloc(sl(), sl(), sl(), sl(), sl(), sl())
              ..add(ChatInitializeConversationsStream(authenticationBloc.state.currentUser!)),
          ),
          BlocProvider<PaymentBloc>(
            create: (_) => PaymentBloc(),
          ),
        ],
        child: ConsultBotanistsScreen(),
      );
    },
  );
}
