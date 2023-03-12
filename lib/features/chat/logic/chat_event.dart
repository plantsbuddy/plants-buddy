part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class ChatConversationItemPressed extends ChatEvent {
  final Conversation conversation;

  ChatConversationItemPressed(this.conversation);
}

class ChatInitializeConversationsStream extends ChatEvent {
  final User currentUser;

  ChatInitializeConversationsStream(this.currentUser);
}

class ChatSendMessagePressed extends ChatEvent {
  final Message message;

  ChatSendMessagePressed(this.message);
}
