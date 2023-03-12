import 'package:plants_buddy/features/chat/domain/entities/conversation.dart';
import 'package:plants_buddy/features/chat/domain/entities/message.dart';
import 'package:plants_buddy/features/chat/domain/repositories/chat_service.dart';

class DeleteMessage {
  final ChatService _chatService;

  DeleteMessage(this._chatService);

  Future<void> call({required Conversation conversation, required Message message}) async {
    return _chatService.deleteMessage(conversation: conversation, message: message);
  }
}
