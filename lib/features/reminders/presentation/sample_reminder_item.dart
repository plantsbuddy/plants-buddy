import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as routes;
import 'package:plants_buddy/features/reminders/logic/reminders_bloc/reminders_bloc.dart';
import 'package:plants_buddy/features/reminders/presentation/reminder_popup.dart';

import '../domain/entities/reminder.dart';

class SampleReminderItem extends StatelessWidget {
  const SampleReminderItem(this._reminder, {Key? key}) : super(key: key);

  final Reminder _reminder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(routes.reminderDetails, arguments: _reminder),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _reminder.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      _reminder.formattedDueTime,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                Spacer(),
                ReminderPopup(_reminder),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
