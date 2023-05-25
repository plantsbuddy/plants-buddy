import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:plants_buddy/features/botanists/domain/entities/appointment_slot.dart';
import '../../../admin/logic/admin_bloc.dart';
import '../../../authentication/domain/entities/botanist.dart';
import '../../../authentication/domain/entities/user.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/entities/botanist_review.dart';
import '../../domain/usecases/botanists_usecases.dart';
import '../botanist_appointment_bloc/botanist_appointment_bloc.dart';

part 'gardener_appointment_event.dart';

part 'gardener_appointment_state.dart';

class GardenerAppointmentBloc extends Bloc<GardenerAppointmentEvent, GardenerAppointmentState> {
  final CancelAppointmentRequest _cancelAppointmentRequest;
  final SendAppointmentRequest _sendAppointmentRequest;
  final GetBotanists _getBotanists;
  final GetSentAppointmentRequestsStream _getSentAppointmentRequestsStream;
  final ReportBotanist _reportBotanist;
  final GetAvailableAppointmentSlots _getAvailableAppointmentSlots;

  GardenerAppointmentBloc(
    this._getBotanists,
    this._getSentAppointmentRequestsStream,
    this._sendAppointmentRequest,
    this._cancelAppointmentRequest,
    this._reportBotanist,
    this._getAvailableAppointmentSlots,
  ) : super(GardenerAppointmentState.initial()) {
    on<GardenerCancelAppointmentRequest>(onGardenerCancelAppointmentRequest);
    on<GardenerSendAppointmentRequest>(onGardenerSendAppointmentRequest);
    on<GardenerInitializeSentAppointmentRequestsStream>(onGardenerInitializeSentAppointmentRequestsStream);
    on<GardenerGetBotanists>(onGardenerGetBotanists);
    on<GardenerDeleteAppointmentRequest>(onGardenerDeleteAppointmentRequest);
    on<GardenerReportBotanist>(onGardenerReportBotanist);
    on<GardenerAppointmentDateSelected>(onGardenerAppointmentDateSelected);
    on<GardenerAppointmentSlotSelected>(onGardenerAppointmentSlotSelected);
    on<GardenerCleanupAppointmentRequest>(onGardenerCleanupAppointmentRequest);
  }

  FutureOr<void> onGardenerInitializeSentAppointmentRequestsStream(
      GardenerInitializeSentAppointmentRequestsStream event, Emitter<GardenerAppointmentState> emit) async {
    final sentAppointmentRequestsStream = await _getSentAppointmentRequestsStream();

    await emit.forEach(sentAppointmentRequestsStream,
        onData: (sentAppointmentRequests) =>
            state.copyWith(sentAppointmentRequests: sentAppointmentRequests, status: AppointmentsListStatus.loaded));
  }

  Future<FutureOr<void>> onGardenerCancelAppointmentRequest(
      GardenerCancelAppointmentRequest event, Emitter<GardenerAppointmentState> emit) async {
    await _cancelAppointmentRequest(event.appointment);
  }

  Future<FutureOr<void>> onGardenerAppointmentDateSelected(
      GardenerAppointmentDateSelected event, Emitter<GardenerAppointmentState> emit) async {
    emit(state.copyWith(date: () => event.date, slotsStatus: AdminDataStatus.loading));

    if (event.date != null) {
      final availableSlots = await _getAvailableAppointmentSlots(botanist: event.botanist, date: event.date!);

      emit(state.copyWith(slotsStatus: AdminDataStatus.loaded, slots: availableSlots, selectedSlotIndex: 0));
    }
  }

  FutureOr<void> onGardenerAppointmentSlotSelected(
      GardenerAppointmentSlotSelected event, Emitter<GardenerAppointmentState> emit) {
    emit(state.copyWith(selectedSlotIndex: state.slots.indexOf(event.slot)));
  }

  Future<FutureOr<void>> onGardenerSendAppointmentRequest(
      GardenerSendAppointmentRequest event, Emitter<GardenerAppointmentState> emit) async {
    emit(state.copyWith(dialogShowing: true));

    await _sendAppointmentRequest(
      botanist: event.botanist,
      date: state.date!,
      notes: event.notes,
      slot: state.slots[state.selectedSlotIndex],
      gardener: event.gardener,
    );

    emit(state.copyWith(dialogShowing: false));
  }

  Future<FutureOr<void>> onGardenerGetBotanists(
      GardenerGetBotanists event, Emitter<GardenerAppointmentState> emit) async {
    final botanists = await _getBotanists();

    emit(state.copyWith(botanists: botanists));
  }

  Future<FutureOr<void>> onGardenerDeleteAppointmentRequest(
      GardenerDeleteAppointmentRequest event, Emitter<GardenerAppointmentState> emit) async {
    await _cancelAppointmentRequest(event.appointment);
  }

  FutureOr<void> onGardenerReportBotanist(GardenerReportBotanist event, Emitter<GardenerAppointmentState> emit) async {
    await _reportBotanist(botanist: event.botanist, reportText: event.reportText);
  }

  FutureOr<void> onGardenerCleanupAppointmentRequest(
      GardenerCleanupAppointmentRequest event, Emitter<GardenerAppointmentState> emit) {
    emit(state.copyWith(slots: [], slotsStatus: AdminDataStatus.loading, date: () => null));
  }
}
