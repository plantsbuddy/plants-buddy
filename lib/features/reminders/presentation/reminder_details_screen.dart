import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:plants_buddy/features/reminders/domain/entities/reminder.dart';

import '../logic/add_reminder_bloc/add_reminder_bloc.dart';

class ReminderDetailsScreen extends StatelessWidget {
  const ReminderDetailsScreen(this._reminder, {Key? key}) : super(key: key);

  final Reminder _reminder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.text_fields,
                            size: 18,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Title',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Theme.of(context).colorScheme.secondary),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Text(
                        _reminder.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.sticky_note_2_outlined,
                            size: 18,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Description',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Theme.of(context).colorScheme.secondary),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Text(
                        _reminder.description,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Wrap(
                runSpacing: 5,
                spacing: 10,
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.start,
                alignment: WrapAlignment.start,
                children: ReminderPeriod.values
                    .map((period) => Chip(
                          backgroundColor: _reminder.repetitionPeriod == period
                              ? Theme.of(context).colorScheme.inversePrimary
                              : null,
                          label: Text(period.toString().split('.')[1].capitalize),
                        ))
                    .toList(),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Date',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Theme.of(context).colorScheme.secondary),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        _reminder.formattedDate,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Time',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Theme.of(context).colorScheme.secondary),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Text(
                        _reminder.formattedTime,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
