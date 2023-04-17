import 'package:flutter/material.dart';

class SampleChatbotResponse extends StatelessWidget {
  const SampleChatbotResponse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        child: Text(
          'I am the chatbot, and i could reply with longer responses',
        ),
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 100),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.15),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
        ),
      ),
    );
  }
}
