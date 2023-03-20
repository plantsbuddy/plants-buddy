part of 'payment_bloc.dart';

@immutable
abstract class PaymentEvent {}

class PaymentInitializePaymentDetailsStream extends PaymentEvent {}
