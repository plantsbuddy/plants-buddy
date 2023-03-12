import 'package:plants_buddy/features/chat/domain/entities/conversation.dart';
import 'package:plants_buddy/features/chat/domain/entities/message.dart';
import 'package:plants_buddy/features/chat/domain/repositories/chat_service.dart';

import '../../../../authentication/domain/entities/user.dart';

class GetConversationsStream {
  final ChatService _chatService;

  GetConversationsStream(this._chatService);

  Future<Stream<List<Conversation>>> call(User currentUser) async {
    return _chatService.getConversations(currentUser);
  }
}
