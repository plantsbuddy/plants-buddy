import 'package:equatable/equatable.dart';

class PaymentTransaction extends Equatable {
  final dynamic id;
  final String botanistName;
  final int time;
  final int amount;

  const PaymentTransaction({
    required this.id,
    required this.botanistName,
    required this.time,
    required this.amount,
  });

  @override
  List<Object?> get props => [id, botanistName, time, amount];
}
