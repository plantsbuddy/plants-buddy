import '../../../../authentication/domain/entities/botanist.dart';
import '../../entities/appointment_slot.dart';
import '../../repositories/appointment_service.dart';

class GetAvailableAppointmentSlots {
  final AppointmentService _appointmentService;

  GetAvailableAppointmentSlots(this._appointmentService);

  Future<List<AppointmentSlot>> call({required Botanist botanist, required DateTime date}) async {
    final pendingAppointments = await _appointmentService.getPendingAppointmentsOfBotanist(botanist);

    final appointmentHours = [9, 10, 11, 12, 13, 14, 15, 16, 17];

    final appointmentMillis =
        appointmentHours.map((hour) => DateTime(date.year, date.month, date.day, hour).millisecondsSinceEpoch).toList();

    for (var pendingAppointmentTimestamp in pendingAppointments) {
      if (appointmentMillis.contains(pendingAppointmentTimestamp)) {
        final index = appointmentMillis.indexOf(pendingAppointmentTimestamp);
        appointmentMillis.remove(pendingAppointmentTimestamp);
        appointmentHours.removeAt(index);
      }
    }

    final availableTimeSlots = appointmentMillis.map((milliseconds) => AppointmentSlot(milliseconds)).toList();

    return availableTimeSlots.where((slot) => slot.startingTime > DateTime.now().millisecondsSinceEpoch).toList();
  }
}
