part of 'reminders_bloc.dart';

@immutable
abstract class RemindersEvent {}

class RemindersStreamInitialize extends RemindersEvent {}
class RemindersDeleteReminderPressed extends RemindersEvent {
  final String reminderId;

  RemindersDeleteReminderPressed(this.reminderId);
}

