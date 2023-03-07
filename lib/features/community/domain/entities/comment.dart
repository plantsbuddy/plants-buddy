import 'package:equatable/equatable.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'user.dart';

class Comment extends Equatable {
  final dynamic author;
  final String body;
  final int postedAt;

  const Comment({
    required this.author,
    required this.body,
    required this.postedAt,
  });

  String get time => timeago.format(DateTime.fromMillisecondsSinceEpoch(postedAt), locale: 'en_short');

  @override
  List<Object?> get props => [author, body, postedAt];
}
