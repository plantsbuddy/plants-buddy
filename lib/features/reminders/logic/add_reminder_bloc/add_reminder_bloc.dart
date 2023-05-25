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
    on<AddReminderDescriptionChanged>(onAddReminderDescriptionChanged);
    on<AddReminderPeriodSelected>(onAddReminderPeriodSelected);
  }

  FutureOr<void> onAddReminderSelectDatePressed(AddReminderSelectDatePressed event, Emitter<AddReminderState> emit) {
    if (event.selectedDate != null) {
      emit(state.copyWith(date: event.selectedDate!));
    }
  }

  FutureOr<void> onAddReminderSelectTimePressed(AddReminderSelectTimePressed event, Emitter<AddReminderState> emit) {
    if (event.selectedTime != null) {
      emit(state.copyWith(time: event.selectedTime));
    }
  }

  FutureOr<void> onAddReminderTitleChanged(AddReminderTitleChanged event, Emitter<AddReminderState> emit) {
    emit(state.copyWith(title: event.title));
  }

  FutureOr<void> onAddReminderDescriptionChanged(AddReminderDescriptionChanged event, Emitter<AddReminderState> emit) {
    emit(state.copyWith(description: event.description));
  }

  FutureOr<void> onAddReminderButtonPressed(AddReminderButtonPressed event, Emitter<AddReminderState> emit) async {
    emit(state.copyWith(
        dialogShowing: true, titleError: null, dateError: false, timeError: false, timePastError: false));

    try {
      if (state.originalReminder == null) {
        await _addReminder(
          title: state.title,
          description: state.description,
          timeOfDay: state.time,
          date: state.date,
          repetitionPeriod: state.repetitionPeriod,
        );
      } else {
        await _updateReminder(
          id: state.originalReminder!.id,
          title: state.title,
          description: state.description,
          timeOfDay: state.time,
          date: state.date,
          repetitionPeriod: state.repetitionPeriod,
        );
      }

      emit(state.copyWith(dialogShowing: false));
    } on ReminderTitleNotWrittenException {
      emit(state.copyWith(titleError: () => 'Please write a title', dialogShowing: false));
    } on ReminderDescriptionNotWrittenException {
      emit(state.copyWith(descriptionError: () => 'Please write a description', dialogShowing: false));
    } on ReminderDateNotSelectedException {
      emit(state.copyWith(dateError: true, dialogShowing: false));
    } on ReminderTimeNotSelectedException {
      emit(state.copyWith(timeError: true, dialogShowing: false));
    } on ReminderTimeInPastException {
      emit(state.copyWith(timePastError: true, dialogShowing: false));
    }

    //emit(state.copyWith(dialogShowing: false));
  }

  FutureOr<void> onAddReminderPeriodSelected(AddReminderPeriodSelected event, Emitter<AddReminderState> emit) {
    emit(state.copyWith(repetitionPeriod: event.reminderPeriod));
  }
}
