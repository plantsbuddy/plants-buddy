import 'package:flutter/material.dart';
import 'package:plants_buddy/features/reminders/domain/entities/reminder.dart';

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
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        _reminder.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.repeat,
                                color: Colors.grey[800],
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Repeat reminder',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black54),
                              ),
                            ],
                          ),
                          Text(
                            'Only once',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.arrow_drop_down_outlined),
                    ],
                  ),
                ),
              ),
            ),
            Container(
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
                            color: Colors.grey[800],
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Date',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black54),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        _reminder.formattedDate,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
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
                            color: Colors.grey[800],
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Time',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black54),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        _reminder.formattedTime,
                        style: Theme.of(context).textTheme.titleLarge,
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
