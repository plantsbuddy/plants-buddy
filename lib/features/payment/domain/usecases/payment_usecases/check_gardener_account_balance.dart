import 'package:plants_buddy/features/payment/domain/repositories/payment_service.dart';

class CheckGardenerAccountBalance {
  final PaymentService _paymentService;

  CheckGardenerAccountBalance(this._paymentService);

  Future<void> call() async {
    //return _paymentService.checkGardenerAccountBalance();
  }
}
