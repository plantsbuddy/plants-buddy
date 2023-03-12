import 'package:firebase_auth/firebase_auth.dart';
import 'package:plants_buddy/core/errors/exceptions.dart';

import '../../../../authentication/domain/entities/botanist.dart';
import '../../entities/botanist_review.dart';
import '../../repositories/appointment_service.dart';

class PostBotanistReview {
  final AppointmentService _appointmentService;

  PostBotanistReview(this._appointmentService);

  Future<void> call({required Botanist botanist, required String review, required int stars}) async {
    // if (review.isEmpty) {
    //   throw BotanistReviewBodyEmptyException();
    // }

    final botanistReview = BotanistReview(
      author: FirebaseAuth.instance.currentUser!.uid,
      review: review.trim(),
      time: DateTime.now().millisecondsSinceEpoch,
      stars: stars,
    );

    await _appointmentService.postBotanistReview(
      botanist: botanist.uid,
      botanistReview: botanistReview,
    );
  }
}
