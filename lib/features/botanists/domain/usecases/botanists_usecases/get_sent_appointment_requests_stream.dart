import 'package:plants_buddy/features/botanists/domain/entities/appointment.dart';

import '../../repositories/appointment_service.dart';

class GetSentAppointmentRequestsStream {
  final AppointmentService _appointmentService;

  GetSentAppointmentRequestsStream(this._appointmentService);

  Future<Stream<List<Appointment>>> call() async {
    return _appointmentService.getSentAppointmentRequestsStream();
  }
}
