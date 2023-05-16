import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../community/domain/entities/user.dart';

class BotanistReview extends Equatable {
  final String? id;
  final User? author;
  final String review;
  final int time;
  final int stars;

  BotanistReview({
    this.id,
    this.author,
    required this.review,
    required this.time,
    required this.stars,
  });

  String get timeAgo => timeago.format(DateTime.fromMillisecondsSinceEpoch(time), locale: 'en_short');

  @override
  List<Object?> get props => [id, author, review, time, stars];
}
