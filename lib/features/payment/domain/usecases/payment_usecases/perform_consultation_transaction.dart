import 'package:plants_buddy/features/payment/domain/repositories/payment_service.dart';

class PerformConsultationTransaction {
  final PaymentService _paymentService;

  PerformConsultationTransaction(this._paymentService);

  Future<void> call({
    required String gardener,
    required String botanist,
  }) async {
    return _paymentService.performConsultationCharges(gardener: gardener, botanist: botanist);
  }
}
