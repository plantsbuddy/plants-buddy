part of 'gardener_appointment_bloc.dart';

@immutable
class GardenerAppointmentState extends Equatable {
  final AppointmentsListStatus status;
  final List<Appointment> sentAppointmentRequests;
  final List<Botanist> botanists;
  final List<BotanistReview> botanistReviews;
  final bool dialogShowing;
  final DateTime? date;
  final List<AppointmentSlot> slots;
  final int selectedSlotIndex;
  final AdminDataStatus slotsStatus;

  GardenerAppointmentState({
    required this.sentAppointmentRequests,
    required this.botanists,
    required this.botanistReviews,
    required this.status,
    this.dialogShowing = false,
    required this.slots,
    required this.slotsStatus,
    required this.date,
    required this.selectedSlotIndex,
  });

  GardenerAppointmentState.initial()
      : sentAppointmentRequests = [],
        botanists = [],
        status = AppointmentsListStatus.loading,
        botanistReviews = [],
        slots = [],
        slotsStatus = AdminDataStatus.loading,
        date = null,
        selectedSlotIndex = 0,
        dialogShowing = false;

  List<Appointment> get pendingAppointments =>
      sentAppointmentRequests.where((request) => request.status == AppointmentStatus.pending).toList();

  List<Appointment> get scheduledAppointments => sentAppointmentRequests
      .where((request) =>
          (request.status == AppointmentStatus.scheduled) &&
          DateTime.now()
              .isBefore(DateTime.fromMillisecondsSinceEpoch(request.slot.startingTime).add(Duration(hours: 1))))
      .toList();

  List<Appointment> get completedAppointments => sentAppointmentRequests
      .where((request) =>
          request.status == AppointmentStatus.completed ||
          request.status == AppointmentStatus.cancelled ||
          request.status == AppointmentStatus.rejected)
      .toList();

  String get formattedDate => date == null ? 'DD/MM/YYYY' : DateFormat('d MMMM, yyyy ').format(date!);

  GardenerAppointmentState copyWith({
    AppointmentsListStatus? status,
    List<Appointment>? sentAppointmentRequests,
    List<Botanist>? botanists,
    List<BotanistReview>? botanistReviews,
    bool? dialogShowing,
    AdminDataStatus? slotsStatus,
    List<AppointmentSlot>? slots,
    DateTime? Function()? date,
    int? selectedSlotIndex,
  }) =>
      GardenerAppointmentState(
        status: status ?? this.status,
        dialogShowing: dialogShowing ?? this.dialogShowing,
        sentAppointmentRequests: sentAppointmentRequests ?? this.sentAppointmentRequests,
        botanists: botanists ?? this.botanists,
        botanistReviews: botanistReviews ?? this.botanistReviews,
        slots: slots ?? this.slots,
        slotsStatus: slotsStatus ?? this.slotsStatus,
        date: date == null ? this.date : date(),
        selectedSlotIndex: selectedSlotIndex ?? this.selectedSlotIndex,
      );

  @override
  List<Object?> get props => [
        status,
        sentAppointmentRequests,
        botanists,
        botanistReviews,
        dialogShowing,
        slots,
        slotsStatus,
        date,
        selectedSlotIndex,
      ];
}
