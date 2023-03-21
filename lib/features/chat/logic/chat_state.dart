part of 'chat_bloc.dart';

enum ConversationsStatus { loading, loaded }

enum MessagesStatus { loading, loaded }

@immutable
class ChatState extends Equatable {
  final MessagesStatus messagesStatus;
  final ConversationsStatus conversationsStatus;
  final List<Message> messages;
  final List<Conversation> conversations;
  final String? _currentConversationId;

  ChatState({
    required this.messagesStatus,
    required this.conversationsStatus,
    required this.messages,
    required this.conversations,
    String? currentConversationId,
  }) : _currentConversationId = currentConversationId;

  ChatState.initial()
      : messages = [],
        conversations = [],
        messagesStatus = MessagesStatus.loading,
        conversationsStatus = ConversationsStatus.loading,
        _currentConversationId = null;

  Conversation? get currentConversation {
    final foundConversation = conversations.where((conversation) => conversation.id == _currentConversationId);

    return foundConversation.isNotEmpty ? foundConversation.elementAt(0) : null;
  }

  ChatState copyWith({
    ConversationsStatus? conversationsStatus,
    MessagesStatus? messagesStatus,
    List<Message>? messages,
    List<Conversation>? conversations,
    Conversation? Function()? currentConversation,
  }) =>
      ChatState(
        messagesStatus: messagesStatus ?? this.messagesStatus,
        conversationsStatus: conversationsStatus ?? this.conversationsStatus,
        messages: messages ?? this.messages,
        conversations: conversations ?? this.conversations,
        currentConversationId: currentConversation == null ? _currentConversationId : currentConversation()!.id,
      );

  @override
  List<Object?> get props => [conversationsStatus,messagesStatus, messages, conversations];
}
