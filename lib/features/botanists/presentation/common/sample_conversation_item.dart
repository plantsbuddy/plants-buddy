import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as app_routes;
import 'package:plants_buddy/features/chat/domain/entities/conversation.dart';
import 'package:plants_buddy/features/chat/logic/chat_bloc.dart';

class SampleConversationItem extends StatelessWidget {
  const SampleConversationItem(this.conversation, {Key? key}) : super(key: key);

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    final bool unreadMessagesExist = conversation.unreadMessagesCount > 0;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(app_routes.chat, arguments: {
          'chat_bloc': context.read<ChatBloc>(),
          'conversation': conversation,
        });
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 10, right: 5, bottom: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: Image.network(
                  conversation.otherUser.profilePicture,
                  height: 60,
                  fit: BoxFit.cover,
                  width: 60,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              conversation.otherUser.username,
                              style: unreadMessagesExist
                                  ? Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)
                                  : Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          // Spacer(),
                          if (conversation.lastMessage != null)
                            Text(
                              conversation.lastMessage!.time,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          conversation.lastMessage != null
                              ? Text(
                                  '${conversation.lastMessage!.sender == conversation.currentUser ? 'You' : conversation.otherUser.username}: ${conversation.lastMessage!.body}',
                                  style: TextStyle(color: Colors.black54),
                                )
                              : Text(
                                  'No messages',
                                  style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                                ),
                          Spacer(),
                          if (unreadMessagesExist)
                            Container(
                              child: Text(
                                conversation.unreadMessagesCount.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 6.5, vertical: 1),
                              decoration:
                                  BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(20)),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
