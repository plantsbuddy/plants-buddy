import 'package:plants_buddy/features/payment/domain/repositories/payment_service.dart';

import '../../../../authentication/domain/entities/user.dart';

class PerformConsultationTransaction {
  final PaymentService _paymentService;

  PerformConsultationTransaction(this._paymentService);

  Future<void> call({
    required String gardenerUid,
    required String botanistUid,
  }) async {
    return _paymentService.performConsultationCharges(gardenerUid: gardenerUid, botanistUid: botanistUid);
  }
}
