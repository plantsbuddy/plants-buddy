import '../../entities/appointment.dart';
import '../../repositories/appointment_service.dart';

class GetReceivedAppointmentRequestsStream {
  final AppointmentService _appointmentService;

  GetReceivedAppointmentRequestsStream(this._appointmentService);

  Future<Stream<List<Appointment>>> call() async {
    return _appointmentService.getReceivedAppointmentRequests();
  }
}
