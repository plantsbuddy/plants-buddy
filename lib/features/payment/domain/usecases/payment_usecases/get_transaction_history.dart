import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plants_buddy/features/payment/domain/repositories/payment_service.dart';

class GetTransactionHistory {
  final PaymentService _paymentService;

  GetTransactionHistory(this._paymentService);

  Future<List<Transaction>> call() async {
    return _paymentService.getTransactionsHistory();
  }
}
