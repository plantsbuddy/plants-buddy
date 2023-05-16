import 'package:firebase_auth/firebase_auth.dart';
import 'package:plants_buddy/core/errors/exceptions.dart';

import '../../../../authentication/domain/entities/botanist.dart';
import '../../entities/botanist_review.dart';
import '../../repositories/appointment_service.dart';

class ReportBotanist {
  final AppointmentService _appointmentService;

  ReportBotanist(this._appointmentService);

  Future<void> call({required Botanist botanist, required String reportText}) async {
    return _appointmentService.reportBotanist(botanist: botanist, reportText: reportText);
  }
}
