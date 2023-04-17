part of 'gardener_appointment_bloc.dart';

@immutable
abstract class GardenerAppointmentEvent {}

class GardenerCancelAppointmentRequest extends GardenerAppointmentEvent {
  final Appointment appointment;

  GardenerCancelAppointmentRequest(this.appointment);
}

class GardenerMarkAppointmentAsCompleted extends GardenerAppointmentEvent {
  final Appointment appointment;

  GardenerMarkAppointmentAsCompleted(this.appointment);
}

class GardenerDeleteAppointmentRequest extends GardenerAppointmentEvent {
  final Appointment appointment;

  GardenerDeleteAppointmentRequest(this.appointment);
}

class GardenerSendAppointmentRequest extends GardenerAppointmentEvent {
  final String notes;
  final User botanist;
  final User gardener;
  final TimeOfDay time;
  final DateTime date;

  GardenerSendAppointmentRequest({
    required this.notes,
    required this.botanist,
    required this.gardener,
    required this.time,
    required this.date,
  });
}



class GardenerGetBotanists extends GardenerAppointmentEvent {}

class GardenerInitializeSentAppointmentRequestsStream extends GardenerAppointmentEvent {}
