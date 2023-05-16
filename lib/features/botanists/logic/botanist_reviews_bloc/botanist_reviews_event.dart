part of 'botanist_reviews_bloc.dart';

@immutable
abstract class BotanistReviewsEvent {}

class BotanistReviewsInitializeReviewsStream extends BotanistReviewsEvent {
  // final Botanist botanist;
  //
  // BotanistReviewsInitializeReviewsStream(this.botanist);
}

class BotanistReviewsPostReview extends BotanistReviewsEvent {
  final String review;

  // final Botanist botanist;
  final int stars;

  BotanistReviewsPostReview({
    // required this.botanist,
    required this.review,
    required this.stars,
  });
}

class BotanistReviewsReportReview extends BotanistReviewsEvent {
  final String reportText;
  final Botanist botanist;
  final BotanistReview review;

  // final Botanist botanist;

  BotanistReviewsReportReview({
    // required this.botanist,
    required this.reportText,
    required this.review,
    required this.botanist,
  });
}
