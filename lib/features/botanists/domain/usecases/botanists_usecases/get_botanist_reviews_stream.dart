import 'package:plants_buddy/features/botanists/domain/entities/botanist_review.dart';

import '../../../../authentication/domain/entities/botanist.dart';
import '../../repositories/appointment_service.dart';

class GetBotanistReviewsStream {
  final AppointmentService _appointmentService;

  GetBotanistReviewsStream(this._appointmentService);

  Future<Stream<List<BotanistReview>>> call(Botanist botanist) async {
    return _appointmentService.getBotanistReviews(botanist);
  }
}
