part of 'add_reminder_bloc.dart';

@immutable
class AddReminderState extends Equatable {
  final String title;
  final int? hour;
  final int? minute;
  final int? dayPeriod;
  final int? date;
  final String? titleError;
  final bool dateError;
  final bool timeError;
  final bool dialogShowing;
  final Reminder? originalReminder;

  //final List<String> repetitionDays;

  AddReminderState.create()
      : title = '',
        hour = null,
        minute = null,
        dayPeriod = null,
        date = null,
        titleError = null,
        dateError = false,
        timeError = false,
        dialogShowing = false,
        // repetitionDays = [],
        originalReminder = null;

  AddReminderState.update(Reminder this.originalReminder)
      : title = originalReminder.title,
        hour = originalReminder.hour,
        minute = originalReminder.minute,
        dayPeriod = originalReminder.dayPeriod,
        date = originalReminder.date,
        // repetitionDays = originalReminder.repetitionDays,
        titleError = null,
        dateError = false,
        dialogShowing = false,
        timeError = false;

  const AddReminderState({
    required this.title,
    required this.hour,
    required this.minute,
    required this.dayPeriod,
    required this.date,
    required this.titleError,
    required this.dateError,
    required this.timeError,
    required this.dialogShowing,
    // required this.repetitionDays,
    this.originalReminder,
  });

  String get formattedDate =>
      date == null ? 'Select date' : DateFormat('d MMMM, yyyy').format(DateTime.fromMillisecondsSinceEpoch(date!));

  String get formattedTime => hour == null ? 'Select time' : '$hour : $minute ${dayPeriod == 0 ? 'AM' : 'PM'}';

  AddReminderState copyWith({
    String? title,
    int? hour,
    int? minute,
    int? dayPeriod,
    int? date,
    String? Function()? titleError,
    bool? dateError,
    bool? timeError,
    bool? dialogShowing,
    List<String>? repetitionDays,
  }) =>
      AddReminderState(
        title: title ?? this.title,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        dayPeriod: dayPeriod ?? this.dayPeriod,
        date: date ?? this.date,
        originalReminder: originalReminder,
        titleError: titleError == null ? this.titleError : titleError(),
        dateError: dateError ?? this.dateError,
        timeError: timeError ?? this.timeError,
        dialogShowing: dialogShowing ?? this.dialogShowing,
        //    repetitionDays: repetitionDays ?? this.repetitionDays,
      );

  @override
  List<Object?> get props => [
        title,
        hour,
        minute,
        dayPeriod,
        date,
        titleError,
        dateError,
        timeError,
        dialogShowing,
        //repetitionDays,
      ];
}
