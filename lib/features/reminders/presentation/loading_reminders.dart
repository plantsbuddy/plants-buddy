import 'package:flutter/material.dart';

class LoadingReminders extends StatelessWidget {
  const LoadingReminders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 200),
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Text(
              'Loading reminders...',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}
