import 'package:equatable/equatable.dart';
import 'package:timeago/timeago.dart' as timeago;

class Report extends Equatable {
  final String authorName;
  final String authorEmail;
  final String body;
  final String authorPicUrl;
  final int _time;

  Report({
    required this.authorName,
    required this.authorEmail,
    required this.body,
    required this.authorPicUrl,
    required int time,
  }) : _time = time;

  String get time => timeago.format(DateTime.fromMillisecondsSinceEpoch(_time), locale: 'en_short');

  @override
  List<Object?> get props => [authorEmail, authorName, authorPicUrl, body, _time];
}
