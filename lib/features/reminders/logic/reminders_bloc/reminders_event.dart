part of 'reminders_bloc.dart';

@immutable
abstract class RemindersEvent {}

class RemindersStreamInitialize extends RemindersEvent {}

class RemindersDeleteReminderPressed extends RemindersEvent {
  final Reminder reminder;

  RemindersDeleteReminderPressed(this.reminder);
}
