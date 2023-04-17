import '../../entities/appointment.dart';
import '../../repositories/appointment_service.dart';

class MarkAppointmentAsCompleted {
  final AppointmentService _appointmentService;

  MarkAppointmentAsCompleted(this._appointmentService);

  Future<void> call(Appointment appointment) async {
    await _appointmentService.completeAppointment(appointment);
  }
}
