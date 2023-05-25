import 'dart:developer';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/reminders/logic/add_reminder_bloc/add_reminder_bloc.dart';
import 'package:plants_buddy/features/reminders/logic/reminders_bloc/reminders_bloc.dart';

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
            } else if (state.timePastError) {
              error = 'Selected time must be in future';
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

          TextEditingController descriptionController = TextEditingController.fromValue(TextEditingValue(
              text: state.description, selection: TextSelection.collapsed(offset: state.description.length)));

          titleController
              .addListener(() => context.read<AddReminderBloc>().add(AddReminderTitleChanged(titleController.text)));
          descriptionController.addListener(
              () => context.read<AddReminderBloc>().add(AddReminderDescriptionChanged(descriptionController.text)));

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    errorText: state.titleError,
                    contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    errorText: state.descriptionError,
                    contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  ),
                  maxLines: 4,
                  minLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                ),
                SizedBox(height: 25),
                Wrap(
                  runSpacing: 5,
                  spacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runAlignment: WrapAlignment.start,
                  alignment: WrapAlignment.start,
                  children: ReminderPeriod.values
                      .map((period) => GestureDetector(
                            child: Chip(
                              backgroundColor: state.repetitionPeriod == period
                                  ? Theme.of(context).colorScheme.inversePrimary
                                  : null,
                              label: Text(period.toString().split('.')[1].capitalize),
                            ),
                            onTap: () =>
                                setState(() => context.read<AddReminderBloc>().add(AddReminderPeriodSelected(period))),
                          ))
                      .toList(),
                ),
                SizedBox(height: 25),
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
                              state.formattedDate,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      initialDate: state.date == null ? DateTime.now() : state.date!,
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
                              state.formattedTime,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    final selectedTime = await showTimePicker(
                      initialTime: state.time ?? TimeOfDay.now(),
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
