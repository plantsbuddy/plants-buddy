part of 'botanist_appointment_bloc.dart';

@immutable
abstract class BotanistAppointmentEvent {}

class BotanistApproveAppointmentRequest extends BotanistAppointmentEvent {
  final Appointment appointment;

  BotanistApproveAppointmentRequest(this.appointment);
}

class BotanistRejectAppointmentRequest extends BotanistAppointmentEvent {
  final Appointment appointment;

  BotanistRejectAppointmentRequest(this.appointment);
}

class BotanistMarkAppointmentAsCompleted extends BotanistAppointmentEvent {
  final Appointment appointment;

  BotanistMarkAppointmentAsCompleted(this.appointment);
}

class BotanistDeleteAppointmentRequestPressed extends BotanistAppointmentEvent {
  final Appointment appointment;

  BotanistDeleteAppointmentRequestPressed(this.appointment);
}

class BotanistInitializeReceivedAppointmentRequestsStream extends BotanistAppointmentEvent {}
