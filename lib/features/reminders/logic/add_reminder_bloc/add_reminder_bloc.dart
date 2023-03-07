import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plants_buddy/core/errors/exceptions.dart';

import '../../domain/entities/reminder.dart';
import '../../domain/usecases/reminders_usecases.dart';

part 'add_reminder_event.dart';

part 'add_reminder_state.dart';

class AddReminderBloc extends Bloc<AddReminderEvent, AddReminderState> {
  final AddReminder _addReminder;
  final UpdateReminder _updateReminder;

  AddReminderBloc(Reminder? originalReminder, this._addReminder, this._updateReminder)
      : super(
          originalReminder == null ? AddReminderState.create() : AddReminderState.update(originalReminder),
        ) {
    on<AddReminderSelectDatePressed>(onAddReminderSelectDatePressed);
    on<AddReminderSelectTimePressed>(onAddReminderSelectTimePressed);
    on<AddReminderTitleChanged>(onAddReminderTitleChanged);
    on<AddReminderButtonPressed>(onAddReminderButtonPressed);
  }

  FutureOr<void> onAddReminderSelectDatePressed(AddReminderSelectDatePressed event, Emitter<AddReminderState> emit) {
    if (event.selectedDate != null) {
      emit(state.copyWith(date: event.selectedDate!.millisecondsSinceEpoch));
    }
  }

  FutureOr<void> onAddReminderSelectTimePressed(AddReminderSelectTimePressed event, Emitter<AddReminderState> emit) {
    if (event.selectedTime != null) {
      int hour = event.selectedTime!.hourOfPeriod;
      int minute = event.selectedTime!.minute;
      int dayPeriod = event.selectedTime!.period.index;

      emit(state.copyWith(hour: hour, minute: minute, dayPeriod: dayPeriod));
    }
  }

  FutureOr<void> onAddReminderTitleChanged(AddReminderTitleChanged event, Emitter<AddReminderState> emit) {
    emit(state.copyWith(title: event.title));
  }

  FutureOr<void> onAddReminderButtonPressed(AddReminderButtonPressed event, Emitter<AddReminderState> emit) async {
    emit(state.copyWith(dialogShowing: true, titleError: null, dateError: false, timeError: false));

    try {
      if (state.originalReminder == null) {
        await _addReminder(
          title: state.title,
          hour: state.hour,
          minute: state.minute,
          dayPeriod: state.dayPeriod,
          date: state.date,
          repetitionDays: [],
        );
      } else {
        await _updateReminder(
          id: state.originalReminder!.id,
          title: state.title,
          hour: state.hour,
          minute: state.minute,
          dayPeriod: state.dayPeriod,
          date: state.date,
          repetitionDays: [],
        );
      }

      emit(state.copyWith(dialogShowing: false));
    } on ReminderTitleNotWrittenException {
      emit(state.copyWith(titleError: () => 'Please write a title', dialogShowing: false));
    } on ReminderDateNotSelectedException {
      emit(state.copyWith(dateError: true, dialogShowing: false));
    } on ReminderTimeNotSelectedException {
      emit(state.copyWith(timeError: true, dialogShowing: false));
    }

    //emit(state.copyWith(dialogShowing: false));
  }
}
