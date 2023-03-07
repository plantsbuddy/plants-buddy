import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../domain/entities/reminder.dart';
import '../logic/add_reminder_bloc/add_reminder_bloc.dart';
import '../presentation/add_reminder_screen.dart';

MaterialPageRoute route(Object? originalReminder) {
  final sl = GetIt.instance;

  originalReminder as Reminder?;

  return MaterialPageRoute(
    builder: (_) {
      return BlocProvider<AddReminderBloc>(
        create: (context) => AddReminderBloc(originalReminder, sl(), sl()),
        child: AddReminderScreen(),
      );
    },
  );
}
