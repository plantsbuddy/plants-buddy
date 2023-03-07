import 'package:flutter/material.dart';

import 'sample_conversation_item.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) => SampleConversationItem(),
    itemCount: 10,
    );
  }
}
