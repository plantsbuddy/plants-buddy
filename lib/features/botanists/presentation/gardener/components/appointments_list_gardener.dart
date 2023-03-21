import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/botanists/logic/gardener_appointment_bloc/gardener_appointment_bloc.dart';
import 'package:plants_buddy/features/botanists/presentation/gardener/components/no_appointments_gardener.dart';

import '../../../domain/entities/appointment.dart';
import '../../../logic/botanist_appointment_bloc/botanist_appointment_bloc.dart';
import 'sample_appointment_item_gardener.dart';

class AppointmentsListGardener extends StatelessWidget {
  const AppointmentsListGardener({required this.appointments, required this.appointmentsType, Key? key})
      : super(key: key);

  final List<Appointment> appointments;
  final AppointmentStatus appointmentsType;

  @override
  Widget build(BuildContext context) {
    final status = context.select((GardenerAppointmentBloc bloc) => bloc.state.status);

    switch (status) {
      case AppointmentsListStatus.loading:
        return Center(child: CircularProgressIndicator());
      case AppointmentsListStatus.loaded:
        return appointments.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15),
                itemBuilder: (context, index) => SampleAppointmentItemGardener(appointments[index]),
                itemCount: appointments.length,
              )
            : NoAppointmentsGardener(appointmentsType);
    }
  }
}
