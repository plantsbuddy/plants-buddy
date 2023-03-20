import 'package:plants_buddy/features/payment/domain/repositories/payment_service.dart';

class GetPaymentDetailsStream {
  final PaymentService _paymentService;

  GetPaymentDetailsStream(this._paymentService);

  Future<Stream<Map<String, dynamic>>> call() async {
    return _paymentService.getPaymentDetails();
  }
}
