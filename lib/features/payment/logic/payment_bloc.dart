import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../domain/entities/payment_transaction.dart';

part 'payment_event.dart';

part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentState.initial()) {
    on<PaymentInitializePaymentDetailsStream>(onPaymentInitializePaymentDetailsStream);
  }

  FutureOr<void> onPaymentInitializePaymentDetailsStream(
      PaymentInitializePaymentDetailsStream event, Emitter<PaymentState> emit) {}
}
