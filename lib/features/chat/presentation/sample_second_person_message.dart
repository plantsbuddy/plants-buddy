import 'package:flutter/material.dart';

class SampleSecondPersonMessage extends StatelessWidget {
  const SampleSecondPersonMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Mohsin Ismail Mohsin Ismail Mohsin Ismail Mohsin Ismail Mohsin Ismail Mohsin Ismail Mohsin Ismail Mohsin Ismail Mohsin Ismail Mohsin Ismail ',
      ),
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 100),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.15),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
