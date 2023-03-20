part of 'botanist_appointment_bloc.dart';

@immutable
class BotanistAppointmentState extends Equatable {
  final List<Appointment> receivedAppointments;

  BotanistAppointmentState(this.receivedAppointments);

  BotanistAppointmentState.initial() : receivedAppointments = [];

  List<Appointment> get pendingAppointments =>
      receivedAppointments.where((request) => request.status == AppointmentStatus.pending).toList();

  List<Appointment> get scheduledAppointments =>
      receivedAppointments.where((request) => request.status == AppointmentStatus.scheduled).toList();

  List<Appointment> get completedAppointments => receivedAppointments
      .where((request) =>
          request.status == AppointmentStatus.rejected ||
          request.status == AppointmentStatus.completed ||
          request.status == AppointmentStatus.cancelled)
      .toList();

  @override
  List<Object?> get props => [receivedAppointments];
}
