import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class PaymentTransaction extends Equatable {
  final dynamic id;
  final String name;
  final int time;
  final int amount;

  const PaymentTransaction({
    required this.id,
    required this.name,
    required this.time,
    required this.amount,
  });

  String get formattedTime => DateFormat('d MMMM, yyyy ').format(DateTime.fromMillisecondsSinceEpoch(time));

  @override
  List<Object?> get props => [id, name, time, amount];
}
