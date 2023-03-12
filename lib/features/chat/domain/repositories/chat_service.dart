import 'package:plants_buddy/features/chat/domain/entities/conversation.dart';
import 'package:plants_buddy/features/chat/domain/entities/message.dart';

import '../../../authentication/domain/entities/user.dart';

abstract class ChatService {
  Future<void> sendMessage(Message message);

  Future<Stream<List<Message>>> getMessagesStream(Conversation conversation);

  Future<Stream<List<Conversation>>> getConversations(User currentUser);

  Future<void> deleteMessage({required Conversation conversation, required Message message});

  Future<void> initializeCurrentConversation(Conversation conversation);

  Future<void> deleteConversation(Conversation conversation);

  Future<void> downloadFile(Message message);
}
