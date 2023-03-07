import 'package:plants_buddy/core/errors/exceptions.dart';
import 'package:plants_buddy/features/reminders/domain/repositories/reminders_repository.dart';

import '../../entities/reminder.dart';

class AddReminder {
  final RemindersRepository _remindersRepository;

  AddReminder(this._remindersRepository);

  Future<void> call({
    required String title,
    required List<String> repetitionDays,
    required int? hour,
    required int? minute,
    required int? dayPeriod,
    required int? date,
  }) async {
    if (title.trim().isEmpty) {
      throw ReminderTitleNotWrittenException();
    }

    if (date == null) {
      throw ReminderDateNotSelectedException();
    }

    if (hour == null) {
      throw ReminderTimeNotSelectedException();
    }

    Reminder reminder = Reminder(
      title: title.trim(),
      repetitionDays: repetitionDays,
      hour: hour,
      minute: minute!,
      dayPeriod: dayPeriod!,
      date: date,
    );

    await _remindersRepository.addReminder(reminder);
  }
}