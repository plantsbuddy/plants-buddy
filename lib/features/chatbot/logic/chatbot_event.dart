part of 'chatbot_bloc.dart';

@immutable
abstract class ChatbotEvent {}

class ChatbotQuerySubmitPressed extends ChatbotEvent {
  final String query;

  ChatbotQuerySubmitPressed(this.query);
}
