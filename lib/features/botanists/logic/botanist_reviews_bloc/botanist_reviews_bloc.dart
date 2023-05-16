import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../authentication/domain/entities/botanist.dart';
import '../../domain/entities/botanist_review.dart';
import '../../domain/usecases/botanists_usecases.dart';

part 'botanist_reviews_event.dart';

part 'botanist_reviews_state.dart';

class BotanistReviewsBloc extends Bloc<BotanistReviewsEvent, BotanistReviewsState> {
  final GetBotanistReviewsStream _getBotanistReviewsStream;
  final PostBotanistReview _postBotanistReview;
  final ReportBotanistReview _reportBotanistReview;

  BotanistReviewsBloc(this._getBotanistReviewsStream, this._postBotanistReview,this._reportBotanistReview, {required Botanist botanist})
      : super(BotanistReviewsState.initial(botanist)) {
    on<BotanistReviewsInitializeReviewsStream>(onBotanistReviewsInitializeReviewsStream);
    on<BotanistReviewsPostReview>(onBotanistReviewsPostReview);
    on<BotanistReviewsReportReview>(onBotanistReviewsReportReview);
  }

  Future<FutureOr<void>> onBotanistReviewsInitializeReviewsStream(
      BotanistReviewsInitializeReviewsStream event, Emitter<BotanistReviewsState> emit) async {
    final botanistReviewsStream = await _getBotanistReviewsStream(state.botanist);

    await emit.forEach(
      botanistReviewsStream,
      onData: (botanistReviews) => state.copyWith(
        reviews: botanistReviews,
        status: BotanistReviewsStatus.loaded,
      ),
    );
  }

  Future<FutureOr<void>> onBotanistReviewsPostReview(
      BotanistReviewsPostReview event, Emitter<BotanistReviewsState> emit) async {
    await _postBotanistReview(
      botanist: state.botanist,
      review: event.review,
      stars: event.stars,
    );
  }

  FutureOr<void> onBotanistReviewsReportReview(BotanistReviewsReportReview event, Emitter<BotanistReviewsState> emit) async {
    await _reportBotanistReview(reportText: event.reportText, botanist: event.botanist, review: event.review);
  }
}
