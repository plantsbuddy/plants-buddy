import 'package:firebase_auth/firebase_auth.dart';
import 'package:plants_buddy/core/errors/exceptions.dart';

import '../../../../authentication/domain/entities/botanist.dart';
import '../../entities/botanist_review.dart';
import '../../repositories/appointment_service.dart';

class ReportBotanistReview {
  final AppointmentService _appointmentService;

  ReportBotanistReview(this._appointmentService);

  Future<void> call({required Botanist botanist, required BotanistReview review, required String reportText}) async {
    return _appointmentService.reportBotanistReview(botanist: botanist, review: review, reportText: reportText);
  }
}
