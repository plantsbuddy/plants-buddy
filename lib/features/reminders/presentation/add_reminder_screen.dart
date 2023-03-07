import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/reminders/logic/add_reminder_bloc/add_reminder_bloc.dart';

import 'repetition_days_dialog.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({Key? key}) : super(key: key);

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add reminder'),
      ),
      body: BlocConsumer<AddReminderBloc, AddReminderState>(
        listener: (context, state) {
          if (state.dialogShowing) {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                    child: Row(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          width: 20,
                        ),
                        Text(state.originalReminder == null ? 'Creating reminder...' : 'Updating reminder...'),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            Future.delayed(const Duration(milliseconds: 200), () => Navigator.of(context).pop());

            String? error;
            if (state.dateError) {
              error = 'Please select a date';
            } else if (state.timeError) {
              error = 'Please select a time';
            }

            if (error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(error),
                    ],
                  ),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(milliseconds: 1500),
                ),
              );
            } else if (error == null && state.titleError == null) {
              Navigator.of(context).pop();
            }
          }
        },
        listenWhen: (previous, current) => previous.dialogShowing != current.dialogShowing,
        builder: (context, state) {
          TextEditingController titleController = TextEditingController.fromValue(
              TextEditingValue(text: state.title, selection: TextSelection.collapsed(offset: state.title.length)));

          titleController
              .addListener(() => context.read<AddReminderBloc>().add(AddReminderTitleChanged(titleController.text)));

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    errorText: state.titleError,
                    contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  ),
                ),
                GestureDetector(
                  child: Padding(
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
                  onTap: () {
                    // showDialog(context: context, builder: (context) {
                    //   return RepetitionDaysDialog();
                    // },);
                  },
                ),
                GestureDetector(
                  child: SizedBox(
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
                              state.formattedDate,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      initialDate:
                          state.date == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(state.date!),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2024),
                      context: context,
                    );

                    context.read<AddReminderBloc>().add(AddReminderSelectDatePressed(selectedDate));
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: SizedBox(
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
                              state.formattedTime,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    final selectedTime = await showTimePicker(
                      initialTime:
                          state.hour == null ? TimeOfDay.now() : TimeOfDay(hour: state.hour!, minute: state.minute!),
                      context: context,
                    );

                    context.read<AddReminderBloc>().add(AddReminderSelectTimePressed(selectedTime));
                  },
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      context.read<AddReminderBloc>().add(AddReminderButtonPressed());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: Text(state.originalReminder == null ? 'Create reminder' : 'Update reminder'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
