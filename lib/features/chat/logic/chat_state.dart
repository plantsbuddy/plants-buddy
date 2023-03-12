part of 'chat_bloc.dart';

@immutable
class ChatState extends Equatable {
  final List<Message> messages;
  final List<Conversation> conversations;
  final String? _currentConversationId;

  ChatState({
    required this.messages,
    required this.conversations,
    String? currentConversationId,
  }) : _currentConversationId = currentConversationId;

  ChatState.initial()
      : messages = [],
        conversations = [],
        _currentConversationId = null;

  Conversation? get currentConversation {
    final foundConversation = conversations.where((conversation) => conversation.id == _currentConversationId);

    return foundConversation.isNotEmpty ? foundConversation.elementAt(0) : null;
  }

  ChatState copyWith({
    List<Message>? messages,
    List<Conversation>? conversations,
    Conversation? Function()? currentConversation,
  }) =>
      ChatState(
        messages: messages ?? this.messages,
        conversations: conversations ?? this.conversations,
        currentConversationId: currentConversation == null ? _currentConversationId : currentConversation()!.id,
      );

  @override
  List<Object?> get props => [messages, conversations];
}
