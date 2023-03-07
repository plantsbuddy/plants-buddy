import 'package:flutter/material.dart';

import '../domain/entities/reminder.dart';
import '../presentation/add_reminder_screen.dart';
import '../presentation/reminder_details_screen.dart';

MaterialPageRoute route(Object? reminder) {
  reminder as Reminder;
  return MaterialPageRoute(
    builder: (_) {
      return ReminderDetailsScreen(reminder);
    },
  );
}
