import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/authentication/logic/authentication_bloc.dart';
import 'package:plants_buddy/features/chat/logic/chat_bloc.dart';
import 'package:plants_buddy/features/chat/presentation/no_chats.dart';

import 'sample_conversation_item.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conversations = context.select((ChatBloc bloc) => bloc.state.conversations);
    final status = context.select((ChatBloc bloc) => bloc.state.conversationsStatus);

    switch (status) {
      case ConversationsStatus.loading:
        return Center(child: CircularProgressIndicator());
      case ConversationsStatus.loaded:
        return conversations.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) => SampleConversationItem(conversations[index]),
                itemCount: conversations.length,
              )
            : NoChats(context.read<AuthenticationBloc>().state.currentUser!);
    }
  }
}
