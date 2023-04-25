import 'package:flutter/material.dart';
import 'package:plants_buddy/features/chatbot/domain/entities/chatbot_message.dart';

class SampleChatbotQuery extends StatelessWidget {
  const SampleChatbotQuery(this.message, {Key? key}) : super(key: key);

  final ChatbotMessage message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        child: Text(message.body),
        margin: EdgeInsets.only(bottom: 10, left: 100, right: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
        ),
      ),
    );
  }
}
