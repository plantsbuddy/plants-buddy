part of 'payment_bloc.dart';

@immutable
class PaymentState extends Equatable {
  final double balance;
  final String cardNumber;
  final List<PaymentTransaction> transactions;

  PaymentState({
    required this.balance,
    required this.cardNumber,
    required this.transactions,
  });

  PaymentState.initial()
      : balance = 0,
        cardNumber = '',
        transactions = [];

  @override
  List<Object?> get props => [balance, cardNumber, transactions];
}
