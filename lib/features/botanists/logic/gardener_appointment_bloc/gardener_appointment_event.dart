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
  final Botanist botanist;
  final User gardener;

  GardenerSendAppointmentRequest({
    required this.notes,
    required this.gardener,
    required this.botanist,
  });
}

class GardenerAppointmentDateSelected extends GardenerAppointmentEvent {
  final Botanist botanist;
  final DateTime? date;

  GardenerAppointmentDateSelected({required this.date, required this.botanist});
}

class GardenerAppointmentSlotSelected extends GardenerAppointmentEvent {
  final AppointmentSlot slot;

  GardenerAppointmentSlotSelected(this.slot);
}

class GardenerCleanupAppointmentRequest extends GardenerAppointmentEvent {}

class GardenerReportBotanist extends GardenerAppointmentEvent {
  final Botanist botanist;
  final String reportText;

  GardenerReportBotanist({required this.botanist, required this.reportText});
}

class GardenerGetBotanists extends GardenerAppointmentEvent {}

class GardenerInitializeSentAppointmentRequestsStream extends GardenerAppointmentEvent {}
