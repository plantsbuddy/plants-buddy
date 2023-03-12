import '../../entities/appointment.dart';
import '../../repositories/appointment_service.dart';

class ApproveAppointmentRequest {
  final AppointmentService _appointmentService;

  ApproveAppointmentRequest(this._appointmentService);

  Future<void> call(Appointment appointment) async {
    await _appointmentService.approveAppointmentRequest(appointment);
  }
}
