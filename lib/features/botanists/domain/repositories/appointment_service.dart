import 'package:plants_buddy/features/authentication/domain/entities/botanist.dart';
import 'package:plants_buddy/features/botanists/domain/entities/appointment.dart';
import 'package:plants_buddy/features/botanists/domain/entities/botanist_review.dart';

abstract class AppointmentService {
  Future<Stream<List<Appointment>>> getSentAppointmentRequestsStream();

  Future<Stream<List<Appointment>>> getReceivedAppointmentRequests();

  Future<void> sendAppointmentRequest(Appointment appointment);

  Future<void> approveAppointmentRequest(Appointment appointment);

  Future<void> rejectAppointmentRequest(Appointment appointment);

  Future<void> cancelAppointmentRequest(Appointment appointment);

  Future<List<Botanist>> getBotanists();

  Future<void> postBotanistReview({required String botanist, required BotanistReview botanistReview});

  Future<Stream<List<BotanistReview>>> getBotanistReviews(Botanist botanist);
}