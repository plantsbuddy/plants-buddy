part of 'chatbot_bloc.dart';

enum ChatbotStatus { initial, waitingForAnswer }

@immutable
class ChatbotState extends Equatable {
  final List<ChatbotMessage> messages;
  final ChatbotStatus status;

  ChatbotState.initial()
      : messages = [],
        status = ChatbotStatus.initial;

  ChatbotState({required this.messages, required this.status});

  ChatbotState copyWith({
    List<ChatbotMessage>? messages,
    ChatbotStatus? status,
  }) =>
      ChatbotState(
        messages: messages ?? this.messages,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [messages, status];
}
