// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import '../logic/gardener_appointment_bloc/gardener_appointment_bloc.dart';
// import '../presentation/gardener/make_appointment_screen.dart';
//
// MaterialPageRoute route() {
//   final sl = GetIt.instance;
//
//   return MaterialPageRoute(
//     builder: (_) {
//       return BlocProvider<GardenerAppointmentBloc>(
//         create: (_) => GardenerAppointmentBloc(sl(), sl(), sl(), sl(), sl(), sl()),
//         child: MakeAppointmentScreen(sl()),
//       );
//     },
//   );
// }
