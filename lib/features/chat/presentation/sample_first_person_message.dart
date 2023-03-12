import 'package:flutter/material.dart';

import '../domain/entities/message.dart';

class SampleFirstPersonMessage extends StatelessWidget {
  const SampleFirstPersonMessage(this.message, {Key? key}) : super(key: key);

  final Message message;

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
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
