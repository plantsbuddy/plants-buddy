import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../community/domain/entities/user.dart';

class BotanistReview extends Equatable {
  final User? author;
  final String review;
  final int time;
  final int stars;

  BotanistReview({
    this.author,
    required this.review,
    required this.time,
    required this.stars,
  });

  String get timeAgo => timeago.format(DateTime.fromMillisecondsSinceEpoch(time), locale: 'en_short');

  @override
  List<Object?> get props => [author, review, time, stars];
}
