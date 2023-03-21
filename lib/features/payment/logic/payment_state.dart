part of 'payment_bloc.dart';

enum PaymentStatus { loading, loaded }

@immutable
class PaymentState extends Equatable {
  final PaymentStatus status;
  final double balance;
  final String? cardNumber;
  final List<PaymentTransaction> transactions;
  final String? cardNumberError;
  final bool dialogShowing;

  PaymentState({
    required this.status,
    required this.balance,
    required this.cardNumber,
    required this.transactions,
    required this.dialogShowing,
    this.cardNumberError,
  });

  PaymentState.initial()
      : balance = 0,
        cardNumber = null,
        dialogShowing = false,
        cardNumberError = null,
        status = PaymentStatus.loading,
        transactions = [];

  PaymentState copyWith({
    double? balance,
    String? cardNumber,
    String? Function()? cardNumberError,
    List<PaymentTransaction>? transactions,
    bool? dialogShowing,
    PaymentStatus? status,
  }) =>
      PaymentState(
        status: status ?? this.status,
        balance: balance ?? this.balance,
        cardNumber: cardNumber ?? this.cardNumber,
        transactions: transactions ?? this.transactions,
        dialogShowing: dialogShowing ?? this.dialogShowing,
        cardNumberError: cardNumberError == null ? this.cardNumberError : cardNumberError(),
      );

  @override
  List<Object?> get props => [status, balance, cardNumber, transactions, cardNumberError, dialogShowing];
}
