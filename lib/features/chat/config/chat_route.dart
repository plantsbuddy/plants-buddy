import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/chat/domain/entities/conversation.dart';
import 'package:plants_buddy/features/chat/presentation/chat_interface.dart';
import '../logic/chat_bloc.dart';

MaterialPageRoute route(Object? arguments) {
  final sl = GetIt.instance;

  arguments as Map<String, dynamic>;

  final chatBloc = arguments['chat_bloc'] as ChatBloc;
  final conversation = arguments['conversation'] as Conversation;

  chatBloc.add(ChatConversationItemPressed(conversation));

  return MaterialPageRoute(
    builder: (_) {
      return BlocProvider.value(
        value: chatBloc,
        child: ChatInterface(conversation),
      );
    },
  );
}
