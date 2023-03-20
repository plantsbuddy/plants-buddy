part of 'botanist_reviews_bloc.dart';

enum BotanistReviewsStatus { loading, loaded }

@immutable
class BotanistReviewsState extends Equatable {
  final BotanistReviewsStatus status;
  final Botanist botanist;
  final List<BotanistReview> reviews;

  BotanistReviewsState({required this.status, required this.reviews, required this.botanist});

  BotanistReviewsState.initial(this.botanist)
      : status = BotanistReviewsStatus.loading,
        reviews = [];

  BotanistReviewsState copyWith({
    BotanistReviewsStatus? status,
    List<BotanistReview>? reviews,
  }) =>
      BotanistReviewsState(
        status: status ?? this.status,
        reviews: reviews ?? this.reviews,
        botanist: botanist,
      );

  @override
  List<Object?> get props => [status, reviews, botanist];
}
