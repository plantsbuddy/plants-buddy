import 'package:plants_buddy/features/payment/domain/repositories/payment_service.dart';

import '../../../../authentication/domain/entities/user.dart';

class AddCardDetailsToStripe {
  final PaymentService _paymentService;

  AddCardDetailsToStripe(this._paymentService);

  Future<void> call({
    required User user,
    required String cardholderName,
    required int cardNumber,
    required int cvv,
    required int expiryYear,
    required int expiryMonth,
  }) async {
    return _paymentService.addCardDetails(
        user: user,
        cardholderName: cardholderName,
        cardNumber: cardNumber,
        cvv: cvv,
        expiryYear: expiryYear,
        expiryMonth: expiryMonth);
  }
}
