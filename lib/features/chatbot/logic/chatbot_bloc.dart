import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../domain/entities/chatbot_message.dart';
import '../domain/usecases/chatbot_usecases.dart';

part 'chatbot_event.dart';

part 'chatbot_state.dart';

class ChatbotBloc extends Bloc<ChatbotEvent, ChatbotState> {
  final GetChatbotResponse _getChatbotResponse;

  ChatbotBloc(this._getChatbotResponse) : super(ChatbotState.initial()) {
    on<ChatbotQuerySubmitPressed>(onChatbotQuerySubmitPressed);
  }

  FutureOr<void> onChatbotQuerySubmitPressed(ChatbotQuerySubmitPressed event, Emitter<ChatbotState> emit) async {
    var updatedMessages = List<ChatbotMessage>.from(state.messages);
    updatedMessages.add(ChatbotMessage(body: event.query, isQuery: true));
    emit(state.copyWith(messages: updatedMessages, status: ChatbotStatus.waitingForAnswer));

    final response = await _getChatbotResponse(event.query);
    updatedMessages = List<ChatbotMessage>.from(state.messages);
    updatedMessages.add(response);
    emit(state.copyWith(messages: updatedMessages, status: ChatbotStatus.initial));
  }
}
