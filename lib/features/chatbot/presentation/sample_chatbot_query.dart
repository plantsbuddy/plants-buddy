import 'package:flutter/material.dart';

class SampleChatbotQuery extends StatelessWidget {
  const SampleChatbotQuery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        child: Text('Hello there how are you'),
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
