import 'package:plants_buddy/features/chat/domain/entities/conversation.dart';
import 'package:plants_buddy/features/chat/domain/entities/message.dart';
import 'package:plants_buddy/features/chat/domain/repositories/chat_service.dart';

class GetMessagesStream {
  final ChatService _chatService;

  GetMessagesStream(this._chatService);

  Future<Stream<List<Message>>> call(Conversation conversation) async {
    return _chatService.getMessagesStream(conversation);
  }
}
