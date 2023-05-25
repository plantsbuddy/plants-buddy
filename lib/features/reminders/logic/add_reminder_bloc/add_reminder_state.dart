part of 'add_reminder_bloc.dart';

enum ReminderPeriod { once, daily, weekly, monthly }

@immutable
class AddReminderState extends Equatable {
  final String title;
  final String description;
  final TimeOfDay? time;
  final DateTime? date;
  final String? titleError;
  final String? descriptionError;
  final bool dateError;
  final bool timeError;
  final bool timePastError;
  final bool dialogShowing;
  final Reminder? originalReminder;

  final ReminderPeriod repetitionPeriod;

  AddReminderState.create()
      : title = '',
        description = '',
        time = null,
        date = null,
        titleError = null,
        descriptionError = null,
        dateError = false,
        timeError = false,
        timePastError = false,
        dialogShowing = false,
        repetitionPeriod = ReminderPeriod.once,
        originalReminder = null;

  AddReminderState.update(Reminder this.originalReminder)
      : title = originalReminder.title,
        description = originalReminder.description,
        time = originalReminder.timeOfDay,
        date = originalReminder.time,
        repetitionPeriod = originalReminder.repetitionPeriod,
        titleError = null,
        descriptionError = null,
        dateError = false,
        dialogShowing = false,
        timePastError = false,
        timeError = false;

  const AddReminderState({
    required this.title,
    required this.description,
    required this.time,
    required this.date,
    required this.titleError,
    required this.descriptionError,
    required this.dateError,
    required this.timeError,
    required this.timePastError,
    required this.dialogShowing,
    required this.repetitionPeriod,
    this.originalReminder,
  });

  String get formattedDate => date == null ? 'Select date' : DateFormat('d MMMM, yyyy').format(date!);

  String get formattedTime =>
      time == null
          ? 'Select time'
          : DateFormat('h : mm a').format(DateTime(0, 1, 1, time!.hour, time!.minute));

  AddReminderState copyWith({
    String? title,
    String? description,
    TimeOfDay? time,
    DateTime? date,
    String? Function()? titleError,
    String? Function()? descriptionError,
    bool? dateError,
    bool? timeError,
    bool? timePastError,
    bool? dialogShowing,
    ReminderPeriod? repetitionPeriod,
  }) =>
      AddReminderState(
        title: title ?? this.title,
        time: time ?? this.time,
        timePastError: timePastError ?? this.timePastError,
        date: date ?? this.date,
        originalReminder: originalReminder,
        titleError: titleError == null ? this.titleError : titleError(),
        dateError: dateError ?? this.dateError,
        timeError: timeError ?? this.timeError,
        dialogShowing: dialogShowing ?? this.dialogShowing,
        repetitionPeriod: repetitionPeriod ?? this.repetitionPeriod,
        description: description ?? this.description,
        descriptionError: descriptionError == null ? this.descriptionError : descriptionError(),
      );

  @override
  List<Object?> get props =>
      [
        title,
        time,
        date,
        titleError,
        dateError,
        timeError,
        timePastError,
        dialogShowing,
        repetitionPeriod,
        description,
        descriptionError,
      ];
}
