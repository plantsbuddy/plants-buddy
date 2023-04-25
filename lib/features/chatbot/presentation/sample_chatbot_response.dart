import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:plants_buddy/features/chatbot/domain/entities/chatbot_message.dart';

class SampleChatbotResponse extends StatelessWidget {
  const SampleChatbotResponse(this.message, {Key? key}) : super(key: key);

  final ChatbotMessage message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        child: Html(
          data: message.body,
        ),
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 100),
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.15),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
        ),
      ),
    );
  }
}
