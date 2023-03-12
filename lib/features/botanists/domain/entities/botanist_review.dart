import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class BotanistReview extends Equatable {
  final String author;
  final String review;
  final int time;
  final int stars;

  BotanistReview({
    required this.author,
    required this.review,
    required this.time,
    required this.stars,
  });

  String get formattedDate => DateFormat('d MMMM, yyyy ').format(DateTime.fromMillisecondsSinceEpoch(time));

  @override
  List<Object?> get props => [author, review, time, stars];
}
