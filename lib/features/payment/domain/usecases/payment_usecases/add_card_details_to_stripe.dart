import 'package:plants_buddy/features/payment/domain/repositories/payment_service.dart';

import '../../../../authentication/domain/entities/user.dart';

class AddCardDetailsToStripe {
  final PaymentService _paymentService;

  AddCardDetailsToStripe(this._paymentService);

  Future<void> call({
    required User user,
    required String cardholderName,
    required String cardNumber,
    required String cvc,
    required String expiryYear,
    required String expiryMonth,
  }) async {
    return _paymentService.addCardDetails(
      user: user,
      cardholderName: cardholderName,
      cardNumber: cardNumber.trim(),
      cvc: cvc.trim(),
      expiryYear: expiryYear.trim(),
      expiryMonth: expiryMonth.trim(),
    );
  }
}
