import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:plants_buddy/core/errors/exceptions.dart';
import 'package:plants_buddy/features/botanists/domain/entities/appointment.dart';

import '../../authentication/domain/entities/user.dart';
import '../domain/entities/payment_transaction.dart';
import '../domain/usecases/payment_usecases.dart';

part 'payment_event.dart';

part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final GetPaymentDetailsStream _getPaymentDetailsStream;
  final AddCardDetailsToStripe _addCardDetailsToStripe;
  final PerformConsultationTransaction _performConsultationTransaction;
  final MarkAppointmentAsCompleted _markAppointmentAsCompleted;

  PaymentBloc(
    this._getPaymentDetailsStream,
    this._addCardDetailsToStripe,
    this._performConsultationTransaction,
    this._markAppointmentAsCompleted,
  ) : super(PaymentState.initial()) {
    on<PaymentInitializePaymentDetailsStream>(onPaymentInitializePaymentDetailsStream);
    on<PaymentAddCardPressed>(onPaymentAddCardPressed);
    on<PaymentPerformConsultationPayment>(onPaymentPerformConsultationPayment);
    on<PaymentChangeLastAppointment>(onPaymentChangeLastAppointment);
    on<PaymentMarkAppointmentAsCompleted>(onPaymentMarkAppointmentAsCompleted);
  }

  FutureOr<void> onPaymentInitializePaymentDetailsStream(
      PaymentInitializePaymentDetailsStream event, Emitter<PaymentState> emit) async {
    final paymentDetailsStream = await _getPaymentDetailsStream();

    await emit.forEach(
      paymentDetailsStream,
      onData: (data) => state.copyWith(
        balance: data['balance'],
        cardNumber: data['card'],
        transactions: data['transactions'],
        status: PaymentStatus.loaded,
      ),
    );
  }

  FutureOr<void> onPaymentAddCardPressed(PaymentAddCardPressed event, Emitter<PaymentState> emit) async {
    emit(state.copyWith(cardNumberError: () => null, dialogShowing: true));
    try {
      await _addCardDetailsToStripe(
        cardholderName: event.cardholderName,
        cardNumber: event.cardNumber,
        cvc: event.cvc,
        expiryMonth: event.expiryMonth,
        expiryYear: event.expiryYear,
        user: event.user,
      );

      emit(state.copyWith(
          balance: 100, cardNumber: event.cardNumber.toString().replaceAll("  ", " "), dialogShowing: false));
    } on InvalidCardNumberException {
      emit(state.copyWith(cardNumberError: () => 'Invalid card details', dialogShowing: false));
    }
  }

  FutureOr<void> onPaymentPerformConsultationPayment(
      PaymentPerformConsultationPayment event, Emitter<PaymentState> emit) async {
    await _performConsultationTransaction(
      botanistUid: event.botanist,
      gardenerUid: event.gardener,
    );
  }

  FutureOr<void> onPaymentChangeLastAppointment(PaymentChangeLastAppointment event, Emitter<PaymentState> emit) {
    emit(state.copyWith(lastAppointment: event.appointment));
  }

  Future<FutureOr<void>> onPaymentMarkAppointmentAsCompleted(
      PaymentMarkAppointmentAsCompleted event, Emitter<PaymentState> emit) async {
    await _markAppointmentAsCompleted(appointment: state.lastAppointment!, minutes: event.minutes);
  }
}
