import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:plants_buddy/core/errors/exceptions.dart';
import 'package:plants_buddy/features/reminders/domain/repositories/reminders_repository.dart';
import 'package:plants_buddy/features/reminders/logic/add_reminder_bloc/add_reminder_bloc.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../entities/reminder.dart';

class UpdateReminder {
  final RemindersRepository _remindersRepository;

  UpdateReminder(this._remindersRepository);

  Future<void> call({
    required String id,
    required String title,
    required String description,
    required ReminderPeriod repetitionPeriod,
    required TimeOfDay? timeOfDay,
    required DateTime? date,
  }) async {
    if (title.trim().isEmpty) {
      throw ReminderTitleNotWrittenException();
    }

    if (description.trim().isEmpty) {
      throw ReminderDescriptionNotWrittenException();
    }

    if (date == null) {
      throw ReminderDateNotSelectedException();
    }

    if (timeOfDay == null) {
      throw ReminderTimeNotSelectedException();
    }

    final time = DateTime(date.year, date.month, date.day, timeOfDay.hour, timeOfDay.minute);

    if (time.isBefore(DateTime.now())) {
      throw ReminderTimeInPastException();
    }

    Reminder reminder = Reminder(
      title: title.trim(),
      description: description.trim(),
      repetitionPeriod: repetitionPeriod,
      time: time,
    );

    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        reminder.time.millisecondsSinceEpoch.toString(),
        reminder.title,
        channelDescription: reminder.description,
        priority: Priority.high,
        subText: 'Reminder',
        importance: Importance.max,
        enableVibration: false,
        styleInformation: BigTextStyleInformation(
          reminder.description,
        ),
      ),
    );

    switch (repetitionPeriod) {
      case ReminderPeriod.once:
        await FlutterLocalNotificationsPlugin().zonedSchedule(
          int.parse(reminder.id),
          reminder.title,
          reminder.description,
          tz.TZDateTime.from(time, tz.local),
          notificationDetails,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        );

        break;

      case ReminderPeriod.daily:
        await FlutterLocalNotificationsPlugin().zonedSchedule(
          int.parse(reminder.id),
          reminder.title,
          reminder.description,
          tz.TZDateTime.from(time, tz.local),
          notificationDetails,
          matchDateTimeComponents: DateTimeComponents.time,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        );

        break;

      case ReminderPeriod.weekly:
        await FlutterLocalNotificationsPlugin().zonedSchedule(
          int.parse(reminder.id),
          reminder.title,
          reminder.description,
          tz.TZDateTime.from(time, tz.local),
          notificationDetails,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        );

        break;

      case ReminderPeriod.monthly:
        await FlutterLocalNotificationsPlugin().zonedSchedule(
          int.parse(reminder.id),
          reminder.title,
          reminder.description,
          tz.TZDateTime.from(time, tz.local),
          notificationDetails,
          matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        );

        break;
    }

    await _remindersRepository.updateReminder(reminderId: id, reminder: reminder);
  }
}
