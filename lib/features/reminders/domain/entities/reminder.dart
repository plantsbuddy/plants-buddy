import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../logic/add_reminder_bloc/add_reminder_bloc.dart';

class Reminder extends Equatable {
  final dynamic id;
  final String title;
  final String description;
  final ReminderPeriod repetitionPeriod;
  final DateTime time;

  Reminder({
    this.id,
    required this.title,
    required this.description,
    required this.repetitionPeriod,
    required this.time,
  });

  String get formattedDate => DateFormat('d MMMM, yyyy ').format(time);

  String get formattedTime => DateFormat('h:mm a').format(time);

  String get formattedDueTime => '$formattedTime • $formattedDate';

  TimeOfDay get timeOfDay => TimeOfDay.fromDateTime(time);

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        repetitionPeriod,
        time,
      ];
}
