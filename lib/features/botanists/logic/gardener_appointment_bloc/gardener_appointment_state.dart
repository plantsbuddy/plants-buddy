part of 'gardener_appointment_bloc.dart';

@immutable
class GardenerAppointmentState extends Equatable {
  final AppointmentsListStatus status;
  final List<Appointment> sentAppointmentRequests;
  final List<Botanist> botanists;
  final List<BotanistReview> botanistReviews;
  final bool dialogShowing;

  // final String? snackbarMessage;

  GardenerAppointmentState({
    required this.sentAppointmentRequests,
    required this.botanists,
    required this.botanistReviews,
    required this.status,
    // required this.snackbarMessage,
    this.dialogShowing = false,
  });

  GardenerAppointmentState.initial()
      : sentAppointmentRequests = [],
        botanists = [],
        status = AppointmentsListStatus.loading,
        botanistReviews = [],
        dialogShowing = false;

  // snackbarMessage = null

  List<Appointment> get pendingAppointments =>
      sentAppointmentRequests.where((request) => request.status == AppointmentStatus.pending).toList();

  List<Appointment> get scheduledAppointments =>
      sentAppointmentRequests.where((request) => request.status == AppointmentStatus.scheduled).toList();

  List<Appointment> get completedAppointments => sentAppointmentRequests
      .where((request) =>
          request.status == AppointmentStatus.completed ||
          request.status == AppointmentStatus.cancelled ||
          request.status == AppointmentStatus.rejected)
      .toList();

  GardenerAppointmentState copyWith({
    AppointmentsListStatus? status,
    List<Appointment>? sentAppointmentRequests,
    List<Botanist>? botanists,
    List<BotanistReview>? botanistReviews,
    bool? dialogShowing,
  }) =>
      GardenerAppointmentState(
        status: status ?? this.status,
        dialogShowing: dialogShowing ?? this.dialogShowing,
        sentAppointmentRequests: sentAppointmentRequests ?? this.sentAppointmentRequests,
        botanists: botanists ?? this.botanists,
        botanistReviews: botanistReviews ?? this.botanistReviews,
        // snackbarMessage: sendAppointmentError == null ? this.snackbarMessage : sendAppointmentError(),
      );

  @override
  List<Object?> get props => [
        status,
        sentAppointmentRequests,
        botanists,
        botanistReviews,
        dialogShowing,
        // snackbarMessage,
      ];
}
