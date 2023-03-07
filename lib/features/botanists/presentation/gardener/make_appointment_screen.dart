import 'package:flutter/material.dart';

class MakeAppointmentScreen extends StatelessWidget {
  const MakeAppointmentScreen({Key? key}) : super(key: key);

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
                label: Text('DD/MM/YYYY'),
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2024),
                    context: context,
                  );
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
                label: Text('HH : MM : A'),
                onPressed: () async {
                  final selectedTime = await showTimePicker(
                    // initialTime:
                    //     state.hour == null ? TimeOfDay.now() : TimeOfDay(hour: state.hour!, minute: state.minute!),
                    context: context, initialTime: TimeOfDay.now(),
                  );
                },
              ),
              SizedBox(height: 20),
              TextField(
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
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (_) => MakeAppointmentScreen(),
                  ),
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
}
