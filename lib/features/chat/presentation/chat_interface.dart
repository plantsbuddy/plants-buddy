import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/chat/presentation/sample_first_person_message.dart';
import 'package:plants_buddy/features/chat/presentation/write_a_message.dart';

import '../domain/entities/conversation.dart';
import '../logic/chat_bloc.dart';
import 'no_messages.dart';
import 'sample_first_person_file.dart';
import 'sample_second_person_message.dart';

class ChatInterface extends StatelessWidget {
  const ChatInterface(this.conversation, {Key? key}) : super(key: key);

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    final messages = context.select((ChatBloc bloc) => bloc.state.messages);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(70),
              child: Image.network(
                conversation.otherUser.profilePicture,
                height: 40,
                fit: BoxFit.cover,
                width: 40,
              ),
            ),
            SizedBox(width: 20),
            Text(conversation.otherUser.username),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: messages.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      final message = messages[index];

                      return message.sender.uid == conversation.currentUser.uid
                          ? SampleFirstPersonMessage(message)
                          : SampleSecondPersonMessage(message);
                    },
                    itemCount: messages.length,
                  )
                : NoMessages(conversation.otherUser),
          ),
          WriteAMessage(conversation),
        ],
      ),
    );
  }
}
