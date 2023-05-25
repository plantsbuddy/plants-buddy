part of 'botanist_appointment_bloc.dart';

enum AppointmentsListStatus { loading, loaded }

@immutable
class BotanistAppointmentState extends Equatable {
  final AppointmentsListStatus status;
  final List<Appointment> receivedAppointments;

  BotanistAppointmentState({
    required this.receivedAppointments,
    required this.status,
  });

  BotanistAppointmentState.initial()
      : receivedAppointments = [],
        status = AppointmentsListStatus.loading;

  List<Appointment> get pendingAppointments =>
      receivedAppointments.where((request) => request.status == AppointmentStatus.pending).toList();

  List<Appointment> get scheduledAppointments => receivedAppointments
      .where((request) =>
          (request.status == AppointmentStatus.scheduled) &&
          DateTime.now()
              .isBefore(DateTime.fromMillisecondsSinceEpoch(request.slot.startingTime).add(Duration(hours: 1))))
      .toList();

  List<Appointment> get completedAppointments => receivedAppointments
      .where((request) =>
          request.status == AppointmentStatus.rejected ||
          request.status == AppointmentStatus.completed ||
          request.status == AppointmentStatus.cancelled)
      .toList();

  BotanistAppointmentState copyWith({
    AppointmentsListStatus? status,
    List<Appointment>? receivedAppointments,
  }) =>
      BotanistAppointmentState(
        receivedAppointments: receivedAppointments ?? this.receivedAppointments,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [status, receivedAppointments];
}
