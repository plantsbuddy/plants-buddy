part of 'payment_bloc.dart';

@immutable
abstract class PaymentEvent {}

class PaymentInitializePaymentDetailsStream extends PaymentEvent {}

class PaymentAddCardPressed extends PaymentEvent {
  final User user;
  final String cardholderName;
  final String cardNumber;
  final String cvc;
  final String expiryYear;
  final String expiryMonth;

  PaymentAddCardPressed({
    required this.user,
    required this.cardholderName,
    required this.cardNumber,
    required this.cvc,
    required this.expiryYear,
    required this.expiryMonth,
  });
}

class PaymentPerformConsultationPayment extends PaymentEvent {
  final String botanist;
  final String gardener;

  PaymentPerformConsultationPayment({required this.botanist, required this.gardener});
}
