import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../authentication/domain/entities/user.dart';
import 'appointment_slot.dart';

enum AppointmentStatus { pending, scheduled, completed, cancelled, rejected }

class Appointment extends Equatable {
  final dynamic id;
  final User gardener;
  final User botanist;
  final String notes;
  final AppointmentSlot slot;
  final String? minutes;

  // final int date;
  final AppointmentStatus status;

  Appointment({
    this.id,
    required this.gardener,
    required this.botanist,
    required this.notes,
    required this.slot,
    this.minutes,
    // required this.date,
    this.status = AppointmentStatus.pending,
  });

  String get formattedDate => DateFormat('dd/MM/yyyy ').format(DateTime.fromMillisecondsSinceEpoch(slot.startingTime));

  String get formattedTime => DateFormat('h:mm a').format(DateTime.fromMillisecondsSinceEpoch(slot.startingTime));

  bool get isDue {
    final startTime = DateTime.fromMillisecondsSinceEpoch(slot.startingTime);
    final currentTime = DateTime.now();

    return currentTime.isAfter(startTime) && currentTime.isBefore(startTime.add(Duration(hours: 1)));
  }

  String get endTimeFormatted =>
      DateFormat('h:mm a').format(DateTime.fromMillisecondsSinceEpoch(slot.startingTime).add(Duration(hours: 1)));

  @override
  List<Object?> get props => [
        id,
        gardener,
        botanist,
        notes,
        slot,
        minutes,
        status,
      ];
}
