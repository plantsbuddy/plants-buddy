import 'package:equatable/equatable.dart';

class ChatbotMessage extends Equatable {
  final String body;
  final bool isQuery;

  const ChatbotMessage({required this.body, required this.isQuery});

  @override
  List<Object?> get props => [body, isQuery];
}
