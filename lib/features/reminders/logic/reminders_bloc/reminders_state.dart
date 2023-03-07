part of 'reminders_bloc.dart';

enum RemindersStatus { loading, loaded }

@immutable
class RemindersState extends Equatable {
  final List<Reminder> reminders;
  final RemindersStatus status;

  RemindersState.initial()
      : reminders = [],
        status = RemindersStatus.loading;

  RemindersState({
    required this.reminders,
    required this.status,
  });

  RemindersState copyWith({
    List<Reminder>? reminders,
    RemindersStatus? status,
  }) =>
      RemindersState(
        reminders: reminders ?? this.reminders,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [reminders, status];
}
