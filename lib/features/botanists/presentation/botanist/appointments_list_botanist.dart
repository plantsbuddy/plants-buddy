import 'package:flutter/material.dart';
import 'package:plants_buddy/features/botanists/presentation/botanist/components/no_appointments_botanist.dart';

import '../../domain/entities/appointment.dart';
import 'components/sample_appointment_item_botanist.dart';

class AppointmentsListBotanist extends StatelessWidget {
  const AppointmentsListBotanist({required this.appointments, required this.appointmentsType, Key? key})
      : super(key: key);

  final List<Appointment> appointments;
  final AppointmentStatus appointmentsType;

  @override
  Widget build(BuildContext context) {
    return appointments.isNotEmpty
        ? ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15),
            itemBuilder: (context, index) => SampleAppointmentItemBotanist(appointments[index]),
            itemCount: appointments.length,
          )
        : NoAppointmentsBotanist(appointmentsType);
  }
}
