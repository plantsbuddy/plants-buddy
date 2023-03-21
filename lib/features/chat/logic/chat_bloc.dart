import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:plants_buddy/features/chat/domain/entities/conversation.dart';

import '../../authentication/domain/entities/user.dart';
import '../domain/entities/message.dart';
import '../domain/usecases/chat_usecases.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final DeleteConversation _deleteConversation;
  final DeleteMessage _deleteMessage;
  final DownloadFile _downloadFile;
  final GetConversationsStream _getConversationsStream;
  final GetMessagesStream _getMessagesStream;
  final SendMessage _sendMessage;

  ChatBloc(
    this._getMessagesStream,
    this._sendMessage,
    this._getConversationsStream,
    this._downloadFile,
    this._deleteMessage,
    this._deleteConversation,
  ) : super(ChatState.initial()) {
    on<ChatConversationItemPressed>(onChatConversationItemPressed);
    on<ChatInitializeConversationsStream>(onChatInitializeConversationsStream);
    on<ChatSendMessagePressed>(onChatSendMessagePressed);
  }

  FutureOr<void> onChatSendMessagePressed(ChatSendMessagePressed event, Emitter<ChatState> emit) async {
    await _sendMessage(event.message);
  }

  FutureOr<void> onChatConversationItemPressed(ChatConversationItemPressed event, Emitter<ChatState> emit) async {
    emit(state.copyWith(currentConversation: () => event.conversation));

    final messagesStream = await _getMessagesStream(event.conversation);

    await emit.forEach(
      messagesStream,
      onData: (messages) => state.copyWith(messages: messages, messagesStatus: MessagesStatus.loaded),
    );
  }

  Future<FutureOr<void>> onChatInitializeConversationsStream(
      ChatInitializeConversationsStream event, Emitter<ChatState> emit) async {
    final conversationsStream = await _getConversationsStream(event.currentUser);

    await emit.forEach(
      conversationsStream,
      onData: (conversations) =>
          state.copyWith(conversations: conversations, conversationsStatus: ConversationsStatus.loaded),
    );
  }
}
