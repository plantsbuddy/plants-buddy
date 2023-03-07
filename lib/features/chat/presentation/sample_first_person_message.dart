import 'package:flutter/material.dart';

class SampleFirstPersonMessage extends StatelessWidget {
  const SampleFirstPersonMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        child: Text(
            'Mohsin Ismail Mohsin Ismail Mohsin Ismail Mohsin Ismail Mohsin Ismail Mohsin Ismail Mohsin Ismail Mohsin Ismail Mohsin Ismail Mohsin Ismail '),
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
