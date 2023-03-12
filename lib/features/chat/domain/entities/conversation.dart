import 'package:equatable/equatable.dart';

import '../../../authentication/domain/entities/user.dart';
import 'message.dart';

class Conversation extends Equatable {
  final dynamic id;
  final User currentUser;
  final User otherUser;
  final Message? lastMessage;
  final int unreadMessagesCount;

  Conversation({
    this.id,
    required this.currentUser,
    required this.otherUser,
    this.lastMessage,
    required this.unreadMessagesCount,
  });

  @override
  List<Object?> get props => [
        id,
        currentUser,
        otherUser,
        lastMessage,
        unreadMessagesCount,
      ];
}
