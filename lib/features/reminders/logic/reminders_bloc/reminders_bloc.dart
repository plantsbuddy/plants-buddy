import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:plants_buddy/features/reminders/domain/usecases/reminders_usecases.dart';

import '../../domain/entities/reminder.dart';
import '../../domain/usecases/reminders_usecases/get_reminders_stream.dart';

part 'reminders_event.dart';

part 'reminders_state.dart';

class RemindersBloc extends Bloc<RemindersEvent, RemindersState> {
  final GetRemindersStream _getRemindersStream;
  final DeleteReminder _deleteReminder;

  RemindersBloc(
    this._getRemindersStream,
    this._deleteReminder,
  ) : super(RemindersState.initial()) {
    on<RemindersStreamInitialize>(onRemindersStreamInitialize);
    on<RemindersDeleteReminderPressed>(onRemindersDeleteReminderPressed);
  }

  Future<FutureOr<void>> onRemindersStreamInitialize(
      RemindersStreamInitialize event, Emitter<RemindersState> emit) async {
    await emit.forEach(
      await _getRemindersStream(),
      onData: (reminders) {
        return state.copyWith(reminders: reminders, status: RemindersStatus.loaded);
      },
    );
  }

  Future<FutureOr<void>> onRemindersDeleteReminderPressed(
      RemindersDeleteReminderPressed event, Emitter<RemindersState> emit) async {
    await _deleteReminder(event.reminder.id);
  }
}
