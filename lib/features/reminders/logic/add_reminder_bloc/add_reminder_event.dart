part of 'add_reminder_bloc.dart';

@immutable
abstract class AddReminderEvent {}

class AddReminderPeriodSelected extends AddReminderEvent {
  final ReminderPeriod reminderPeriod;

  AddReminderPeriodSelected(this.reminderPeriod);
}

class AddReminderSelectDatePressed extends AddReminderEvent {
  final DateTime? selectedDate;

  AddReminderSelectDatePressed(this.selectedDate);
}

class AddReminderSelectTimePressed extends AddReminderEvent {
  final TimeOfDay? selectedTime;

  AddReminderSelectTimePressed(this.selectedTime);
}

class AddReminderTitleChanged extends AddReminderEvent {
  final String title;

  AddReminderTitleChanged(this.title);
}

class AddReminderDescriptionChanged extends AddReminderEvent {
  final String description;

  AddReminderDescriptionChanged(this.description);
}

class AddReminderButtonPressed extends AddReminderEvent {}
