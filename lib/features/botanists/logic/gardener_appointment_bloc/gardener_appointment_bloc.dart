import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:plants_buddy/core/errors/exceptions.dart';
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
  final MarkAppointmentAsCompleted _markAppointmentAsCompleted;

  GardenerAppointmentBloc(
    this._getBotanists,
    this._getSentAppointmentRequestsStream,
    this._sendAppointmentRequest,
    this._cancelAppointmentRequest,
    this._markAppointmentAsCompleted,
  ) : super(GardenerAppointmentState.initial()) {
    on<GardenerCancelAppointmentRequest>(onGardenerCancelAppointmentRequest);
    on<GardenerSendAppointmentRequest>(onGardenerSendAppointmentRequest);
    on<GardenerInitializeSentAppointmentRequestsStream>(onGardenerInitializeSentAppointmentRequestsStream);
    on<GardenerGetBotanists>(onGardenerGetBotanists);
    on<GardenerDeleteAppointmentRequest>(onGardenerDeleteAppointmentRequest);
    on<GardenerMarkAppointmentAsCompleted>(onGardenerMarkAppointmentAsCompleted);
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

  Future<FutureOr<void>> onGardenerSendAppointmentRequest(
      GardenerSendAppointmentRequest event, Emitter<GardenerAppointmentState> emit) async {
    emit(state.copyWith(dialogShowing: true));

    await _sendAppointmentRequest(
      botanist: event.botanist,
      date: event.date,
      notes: event.notes,
      time: event.time,
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

  FutureOr<void> onGardenerMarkAppointmentAsCompleted(
      GardenerMarkAppointmentAsCompleted event, Emitter<GardenerAppointmentState> emit) async {
    await _markAppointmentAsCompleted(event.appointment);
  }
}
