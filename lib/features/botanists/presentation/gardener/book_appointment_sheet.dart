import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:plants_buddy/features/authentication/logic/authentication_bloc.dart';
import 'package:plants_buddy/features/botanists/logic/gardener_appointment_bloc/gardener_appointment_bloc.dart';

import '../../../authentication/domain/entities/botanist.dart';

class BookAppointmentSheet extends StatefulWidget {
  const BookAppointmentSheet(this.botanist, {Key? key}) : super(key: key);

  final Botanist botanist;

  @override
  State<BookAppointmentSheet> createState() => _BookAppointmentSheetState();
}

class _BookAppointmentSheetState extends State<BookAppointmentSheet> {
  TimeOfDay? _time;
  DateTime? _date;
  bool errorShowing = false;

  late final TextEditingController notesController;

  @override
  void initState() {
    notesController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Book Appointment',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 15),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.tertiary,
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                ).copyWith(
                  elevation: ButtonStyleButton.allOrNull(0.0),
                ),
                icon: Icon(Icons.calendar_month),
                label: Text(formattedDate),
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    initialDate: _date ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025),
                    context: context,
                  );

                  setState(() {
                    _date = selectedDate;
                    errorShowing = false;
                  });
                },
              ),
              SizedBox(height: 15),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.tertiary,
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                ).copyWith(
                  elevation: ButtonStyleButton.allOrNull(0.0),
                ),
                icon: Icon(Icons.access_time_filled),
                label: Text(formattedTime),
                onPressed: () async {
                  final selectedTime = await showTimePicker(
                    // initialTime:
                    //     state.hour == null ? TimeOfDay.now() : TimeOfDay(hour: state.hour!, minute: state.minute!),
                    context: context, initialTime: _time ?? TimeOfDay.now(),
                  );

                  setState(() {
                    _time = selectedTime;
                    errorShowing = false;
                  });
                },
              ),
              if (errorShowing)
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 15),
                  child: Text(
                    'Please select a date and time',
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              SizedBox(height: 20),
              TextField(
                controller: notesController,
                decoration: InputDecoration(
                  labelText: 'Notes',
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                ),
                maxLines: 4,
                minLines: 1,
              ),
              SizedBox(height: 25),
              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_date == null || _time == null) {
                      setState(() => errorShowing = true);
                    } else {
                      context.read<GardenerAppointmentBloc>().add(
                            GardenerSendAppointmentRequest(
                              notes: notesController.text,
                              botanist: widget.botanist,
                              gardener: context.read<AuthenticationBloc>().state.currentUser!,
                              time: _time!,
                              date: _date!,
                            ),
                          );

                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: Text('Book Appointment'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get formattedDate => _date == null ? 'DD/MM/YYYY' : DateFormat('d MMMM, yyyy ').format(_date!);

  String get formattedTime => _time == null
      ? 'HH : MM : A'
      : '${_time!.hourOfPeriod} : ${_time!.minute} ${_time!.period == DayPeriod.am ? 'AM' : 'PM'}';

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }
}
