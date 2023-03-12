import 'package:flutter/material.dart';

import '../../../../authentication/domain/entities/user.dart';
import '../../entities/appointment.dart';
import '../../repositories/appointment_service.dart';

class SendAppointmentRequest {
  final AppointmentService _appointmentService;

  SendAppointmentRequest(this._appointmentService);

  Future<void> call({
    required String notes,
    required TimeOfDay time,
    required DateTime date,
    required User gardener,
    required User botanist,
  }) async {
    Appointment appointmentRequest = Appointment(
      botanist: botanist,
      gardener: gardener,
      notes: notes.trim(),
      hour: time.hourOfPeriod,
      minute: time.minute,
      dayPeriod: DayPeriod.values.indexOf(time.period),
      date: date.millisecondsSinceEpoch,
    );

    await _appointmentService.sendAppointmentRequest(appointmentRequest);
  }
}
