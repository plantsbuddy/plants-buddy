import '../../entities/appointment.dart';
import '../../repositories/appointment_service.dart';

class CancelAppointmentRequest {
  final AppointmentService _appointmentService;

  CancelAppointmentRequest(this._appointmentService);

  Future<void> call(Appointment appointment) async {
    if (appointment.status == AppointmentStatus.pending) {
      return _appointmentService.cancelAppointmentRequest(appointment);
    } else {
      return _appointmentService.deleteAppointmentRequest(appointment);
    }
  }
}
