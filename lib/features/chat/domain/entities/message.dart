import 'package:equatable/equatable.dart';

import 'package:timeago/timeago.dart' as timeago;

import '../../../authentication/domain/entities/user.dart';

class Message extends Equatable {
  final dynamic id;
  final String body;
  final int timestamp;
  final User sender;
  final User receiver;

  Message({
    this.id,
    required this.body,
    required this.timestamp,
    required this.sender,
    required this.receiver,
  });

  String get time => timeago.format(DateTime.fromMillisecondsSinceEpoch(timestamp), locale: 'en_short');

  @override
  List<Object?> get props => [id, body, timestamp, sender, receiver];
}
