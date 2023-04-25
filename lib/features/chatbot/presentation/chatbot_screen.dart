import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/chatbot/presentation/ask_a_query.dart';
import 'package:plants_buddy/features/chatbot/presentation/sample_chatbot_query.dart';

import '../logic/chatbot_bloc.dart';
import 'chatbot_initial_view.dart';
import 'sample_chatbot_response.dart';

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
          BlocBuilder<ChatbotBloc, ChatbotState>(
            builder: (context, state) {
              return state.messages.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final message = state.messages[index];
                          return message.isQuery ? SampleChatbotQuery(message) : SampleChatbotResponse(message);
                        },
                        itemCount: state.messages.length,
                      ),
                    )
                  : Expanded(child: ChatbotInitialView());
            },
          ),
          AskAQuery(),
        ],
      ),
    );
  }
}
