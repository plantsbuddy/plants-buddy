import '../../../../botanists/domain/entities/appointment.dart';
import '../../../../botanists/domain/repositories/appointment_service.dart';

class MarkAppointmentAsCompleted {
  final AppointmentService _appointmentService;

  MarkAppointmentAsCompleted(this._appointmentService);

  Future<void> call({required Appointment appointment, required String minutes}) async {
    await _appointmentService.completeAppointment(appointment: appointment, minutes: minutes.trim());
  }
}
