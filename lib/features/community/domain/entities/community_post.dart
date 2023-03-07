import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'comment.dart';
import 'user.dart';

class CommunityPost extends Equatable {
  final dynamic author;
  final dynamic id;
  final String title;
  final String description;
  final String? category;
  final int postedAt;
  final String? imageUrl;
  final List<Comment>? comments;
  final int? commentsCount;

  const CommunityPost({
    this.id,
    required this.author,
    required this.title,
    required this.description,
    required this.postedAt,
    this.category,
    this.imageUrl,
    this.comments,
    this.commentsCount,
  });

  String get timeAgo => timeago.format(DateTime.fromMillisecondsSinceEpoch(postedAt), locale: 'en_short');

  String get time => DateFormat('h:mm a • d MMMM, yyyy ').format(DateTime.fromMillisecondsSinceEpoch(postedAt));
  //'5 April, 2022'
  @override
  List<Object?> get props => [id, author, title, description, category, postedAt, imageUrl, comments];
}
