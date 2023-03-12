import '../../entities/appointment.dart';
import '../../repositories/appointment_service.dart';

class RejectAppointmentRequest {
  final AppointmentService _appointmentService;

  RejectAppointmentRequest(this._appointmentService);

  Future<void> call(Appointment appointment) async {
    await _appointmentService.rejectAppointmentRequest(appointment);
  }
}
