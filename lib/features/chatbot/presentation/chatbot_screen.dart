import 'package:flutter/material.dart';
import 'package:plants_buddy/features/chatbot/presentation/ask_a_query.dart';
import 'package:plants_buddy/features/chatbot/presentation/sample_chatbot_response.dart';

import 'chatbot_initial_view.dart';
import 'sample_chatbot_query.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
      ),
      body: Column(
        children: [
          Expanded(child: ChatbotInitialView()),
          AskAQuery(),
        ],
      ),
    );
  }
}
