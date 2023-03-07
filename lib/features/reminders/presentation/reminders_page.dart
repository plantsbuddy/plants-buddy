import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as routes;
import 'package:plants_buddy/features/reminders/presentation/sample_reminder_item.dart';

import '../domain/entities/reminder.dart';
import '../logic/reminders_bloc/reminders_bloc.dart';
import 'loading_reminders.dart';
import 'no_reminders.dart';

class RemindersPage extends StatelessWidget {
  const RemindersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RemindersBloc, RemindersState>(
        builder: (context, state) {
          switch (state.status) {
            case RemindersStatus.loading:
              return LoadingReminders();

            case RemindersStatus.loaded:
              return state.reminders.isNotEmpty
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        return SampleReminderItem(state.reminders[index]);
                      },
                      itemCount: state.reminders.length,
                    )
                  : NoReminders();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed(routes.addReminder),
      ),
    );
  }
}
