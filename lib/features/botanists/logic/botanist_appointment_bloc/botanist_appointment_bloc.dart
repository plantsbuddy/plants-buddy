import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:plants_buddy/features/botanists/domain/entities/appointment.dart';

import '../../domain/usecases/botanists_usecases.dart';

part 'botanist_appointment_event.dart';

part 'botanist_appointment_state.dart';

class BotanistAppointmentBloc extends Bloc<BotanistAppointmentEvent, BotanistAppointmentState> {
  final GetReceivedAppointmentRequestsStream _getReceivedAppointmentRequestsStream;
  final ApproveAppointmentRequest _approveAppointmentRequest;
  final RejectAppointmentRequest _rejectAppointmentRequest;
  final CancelAppointmentRequest _cancelAppointmentRequest;

  BotanistAppointmentBloc(
    this._getReceivedAppointmentRequestsStream,
    this._approveAppointmentRequest,
    this._rejectAppointmentRequest,
    this._cancelAppointmentRequest,
  ) : super(BotanistAppointmentState.initial()) {
    on<BotanistInitializeReceivedAppointmentRequestsStream>(onBotanistInitializeReceivedAppointmentRequestsStream);
    on<BotanistApproveAppointmentRequest>(onBotanistApproveAppointmentRequest);
    on<BotanistRejectAppointmentRequest>(onBotanistRejectAppointmentRequest);
    on<BotanistDeleteAppointmentRequestPressed>(onBotanistDeleteAppointmentRequestPressed);
  }

  Future<FutureOr<void>> onBotanistInitializeReceivedAppointmentRequestsStream(
      BotanistInitializeReceivedAppointmentRequestsStream event, Emitter<BotanistAppointmentState> emit) async {
    final receivedAppointmentRequestsStream = await _getReceivedAppointmentRequestsStream();

    await emit.forEach(
      receivedAppointmentRequestsStream,
      onData: (receivedAppointmentRequests) => BotanistAppointmentState(receivedAppointmentRequests),
    );
  }

  Future<FutureOr<void>> onBotanistApproveAppointmentRequest(
      BotanistApproveAppointmentRequest event, Emitter<BotanistAppointmentState> emit) async {
    await _approveAppointmentRequest(event.appointment);
  }

  FutureOr<void> onBotanistRejectAppointmentRequest(
      BotanistRejectAppointmentRequest event, Emitter<BotanistAppointmentState> emit) async {
    await _rejectAppointmentRequest(event.appointment);
  }

  FutureOr<void> onBotanistDeleteAppointmentRequestPressed(
      BotanistDeleteAppointmentRequestPressed event, Emitter<BotanistAppointmentState> emit) async {
    await _cancelAppointmentRequest(event.appointment);
  }
}
