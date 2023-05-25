import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as routes;
import 'package:plants_buddy/features/community/domain/entities/community_post.dart';
import 'package:plants_buddy/features/community/logic/community_bloc/community_bloc.dart';
import 'package:plants_buddy/features/reminders/logic/reminders_bloc/reminders_bloc.dart';

import '../domain/entities/reminder.dart';

class ReminderPopup extends StatelessWidget {
  const ReminderPopup(this._reminder, {Key? key}) : super(key: key);

  final Reminder _reminder;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) =>
      [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Icon(
                Icons.edit,
                color: Color(0xFF6c6c6c),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Edit',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(
                Icons.delete,
                color: Color(0xFF6c6c6c),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Delete',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
      offset: Offset(0, 50),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onSelected: (option) {
        if (option == 1) {
          Navigator.of(context).pushNamed(routes.addReminder, arguments: _reminder);
        } else if (option == 2) {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('Confirm delete'),
                content: Text('Are you sure you want to delete this reminder?'),
                actions: [
                  TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel')),
                  TextButton(
                    onPressed: () {
                      context.read<RemindersBloc>().add(RemindersDeleteReminderPressed(_reminder));
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Deleting reminder...'),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(milliseconds: 1500),
                        ),
                      );
                    },
                    child: Text('Delete'),
                    style: TextButton.styleFrom(foregroundColor: Theme
                        .of(context)
                        .colorScheme
                        .error),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
