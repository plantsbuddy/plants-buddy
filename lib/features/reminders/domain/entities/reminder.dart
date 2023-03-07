import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Reminder extends Equatable {
  final dynamic id;
  final String title;
  final List<String> repetitionDays;
  final int hour;
  final int minute;
  final int dayPeriod;
  final int date;

  Reminder({
    this.id,
    required this.title,
    required this.repetitionDays,
    required this.hour,
    required this.minute,
    required this.dayPeriod,
    required this.date,
  });

  String get formattedDate => DateFormat('d MMMM, yyyy ').format(DateTime.fromMillisecondsSinceEpoch(date));

  String get formattedTime => '$hour : $minute ${dayPeriod == 0 ? 'AM' : 'PM'}';

  String get formattedDueTime => '$formattedTime • $formattedDate';

  @override
  List<Object?> get props => [id, title, repetitionDays, hour, minute, dayPeriod, date];
}
