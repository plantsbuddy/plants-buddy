import 'package:flutter/material.dart';

class RepetitionDaysDialog extends StatelessWidget {
  const RepetitionDaysDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Text'),
          CheckboxListTile(
            title: Text('Monday'),
            dense: true,
            value: false,
            onChanged: (newValue) {},
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ],
      ),
    );
  }
}
