import 'package:plants_buddy/features/chat/domain/entities/conversation.dart';
import 'package:plants_buddy/features/chat/domain/entities/message.dart';
import 'package:plants_buddy/features/chat/domain/repositories/chat_service.dart';

class DeleteConversation {
  final ChatService _chatService;

  DeleteConversation(this._chatService);

  Future<void> call(Conversation conversation) async {
    return _chatService.deleteConversation(conversation);
  }
}
