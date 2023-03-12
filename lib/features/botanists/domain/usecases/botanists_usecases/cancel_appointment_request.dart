import '../../entities/appointment.dart';
import '../../repositories/appointment_service.dart';

class CancelAppointmentRequest {
  final AppointmentService _appointmentService;

  CancelAppointmentRequest(this._appointmentService);

  Future<void> call(Appointment appointment) async {
    await _appointmentService.cancelAppointmentRequest(appointment);
  }
}
