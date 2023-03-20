import 'package:flutter/material.dart';

import '../domain/entities/message.dart';

class SampleSecondPersonMessage extends StatelessWidget {
  const SampleSecondPersonMessage(this.message, {Key? key}) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        child: Text(
          message.body,
        ),
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 100),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.15),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
