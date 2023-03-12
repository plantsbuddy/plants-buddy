part of 'gardener_appointment_bloc.dart';

@immutable
abstract class GardenerAppointmentEvent {}

class GardenerCancelAppointmentRequest extends GardenerAppointmentEvent {
  final Appointment appointment;

  GardenerCancelAppointmentRequest(this.appointment);
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

class GardenerInitializeBotanistReviewsStream extends GardenerAppointmentEvent {
  final Botanist botanist;

  GardenerInitializeBotanistReviewsStream(this.botanist);
}

class GardenerPostBotanistReview extends GardenerAppointmentEvent {
  final String review;
  final Botanist botanist;
  final int stars;

  GardenerPostBotanistReview({
    required this.botanist,
    required this.review,
    required this.stars,
  });
}

class GardenerGetBotanists extends GardenerAppointmentEvent {}

class GardenerInitializeSentAppointmentRequestsStream extends GardenerAppointmentEvent {}
