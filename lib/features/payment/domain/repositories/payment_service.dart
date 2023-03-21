import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../authentication/domain/entities/user.dart';

abstract class PaymentService {
  Future<void> addCardDetails({
    required User user,
    required String cardholderName,
    required String cardNumber,
    required String cvc,
    required String expiryYear,
    required String expiryMonth,
  });

  // Future<bool> checkGardenerAccountBalance();

  Future<Stream<Map<String, dynamic>>> getPaymentDetails();

  Future<List<Transaction>> getTransactionsHistory();

  Future<void> performConsultationCharges({
    required String gardenerUid,
    required String botanistUid,
  });
}
