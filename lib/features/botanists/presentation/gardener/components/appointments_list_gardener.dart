import 'package:flutter/material.dart';
import 'package:plants_buddy/features/botanists/presentation/gardener/components/no_appointments_gardener.dart';

import '../../../domain/entities/appointment.dart';
import 'sample_appointment_item_gardener.dart';

class AppointmentsListGardener extends StatelessWidget {
  const AppointmentsListGardener({required this.appointments, required this.appointmentsType, Key? key})
      : super(key: key);

  final List<Appointment> appointments;
  final AppointmentStatus appointmentsType;

  @override
  Widget build(BuildContext context) {
    return appointments.isNotEmpty
        ? ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15),
            itemBuilder: (context, index) => SampleAppointmentItemGardener(appointments[index]),
            itemCount: appointments.length,
          )
        : NoAppointmentsGardener(appointmentsType);
  }
}
