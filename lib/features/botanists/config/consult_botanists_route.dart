import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/botanists/presentation/gardener/consult_botanists_screen.dart';
import 'package:plants_buddy/features/chat/logic/chat_bloc.dart';

import '../../authentication/logic/authentication_bloc.dart';
import '../../payment/logic/payment_bloc.dart';
import '../logic/gardener_appointment_bloc/gardener_appointment_bloc.dart';

MaterialPageRoute route(Object? data) {
  final sl = GetIt.instance;

  data as Map<String, dynamic>;

  final authenticationBloc = data['authentication_bloc'] as AuthenticationBloc;
  final paymentBloc = data['payment_bloc'] as PaymentBloc;


  return MaterialPageRoute(
    builder: (_) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<GardenerAppointmentBloc>(
            create: (_) =>
                GardenerAppointmentBloc(sl(), sl(), sl(), sl(),sl())..add(GardenerInitializeSentAppointmentRequestsStream()),
            lazy: false,
          ),
          BlocProvider.value(value: authenticationBloc),
          BlocProvider.value(value: paymentBloc),
          BlocProvider<ChatBloc>(
            create: (_) => ChatBloc(sl(), sl(), sl(), sl(), sl(), sl())
              ..add(ChatInitializeConversationsStream(authenticationBloc.state.currentUser!)),
            lazy: false,
          ),
        ],
        child: ConsultBotanistsScreen(),
      );
    },
  );
}
