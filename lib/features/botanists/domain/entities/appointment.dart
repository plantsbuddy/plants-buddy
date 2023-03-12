import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../authentication/domain/entities/user.dart';

enum AppointmentStatus { pending, scheduled, completed, cancelled, rejected }

class Appointment extends Equatable {
  final dynamic id;
  final User gardener;
  final User botanist;
  final String notes;
  final int hour;
  final int minute;
  final int dayPeriod;
  final int date;
  final AppointmentStatus status;

  Appointment({
    this.id,
    required this.gardener,
    required this.botanist,
    required this.notes,
    required this.hour,
    required this.minute,
    required this.dayPeriod,
    required this.date,
    this.status = AppointmentStatus.pending,
  });

  String get formattedDate => DateFormat('dd/MM/yyyy ').format(DateTime.fromMillisecondsSinceEpoch(date));

  String get formattedTime => '$hour:$minute ${dayPeriod == 0 ? 'AM' : 'PM'}';

  @override
  List<Object?> get props => [id, gardener, botanist, notes, hour, minute, dayPeriod, date, status];
}
