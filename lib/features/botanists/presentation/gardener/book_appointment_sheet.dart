import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/admin/logic/admin_bloc.dart';
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
  bool errorShowing = false;

  late final TextEditingController notesController;

  @override
  void initState() {
    notesController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GardenerAppointmentBloc>().state;

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
                ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                icon: Icon(Icons.calendar_month),
                label: Text(state.formattedDate),
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    initialDate: state.date ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2024),
                    context: context,
                  );

                  context
                      .read<GardenerAppointmentBloc>()
                      .add(GardenerAppointmentDateSelected(date: selectedDate, botanist: widget.botanist));

                  setState(() {
                    errorShowing = false;
                  });
                },
              ),
              SizedBox(height: 15),
              if (errorShowing)
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 15),
                  child: Text(
                    'Please select a date',
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              if (state.date != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available appointment slots (24 hours format)',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(height: 10),
                    state.slotsStatus == AdminDataStatus.loaded
                        ? (state.slots.isNotEmpty
                            ? Wrap(
                                runSpacing: 5,
                                spacing: 10,
                                children: state.slots
                                    .map((slot) => GestureDetector(
                                          child: Chip(
                                            backgroundColor: slot == state.slots[state.selectedSlotIndex]
                                                ? Theme.of(context).colorScheme.inversePrimary
                                                : null,
                                            label: Text(slot.text),
                                            visualDensity: VisualDensity.compact,
                                          ),
                                          onTap: () => setState(() => context
                                              .read<GardenerAppointmentBloc>()
                                              .add(GardenerAppointmentSlotSelected(slot))),
                                        ))
                                    .toList(),
                              )
                            : Text(
                                'No slots available for selected date',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black45),
                              ))
                        : CircularProgressIndicator(),
                  ],
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
                textCapitalization: TextCapitalization.sentences,
              ),
              SizedBox(height: 25),
              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (state.date == null) {
                      setState(() => errorShowing = true);
                    } else {
                      context.read<GardenerAppointmentBloc>().add(
                            GardenerSendAppointmentRequest(
                              notes: notesController.text,
                              botanist: widget.botanist,
                              gardener: context.read<AuthenticationBloc>().state.currentUser!,
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

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }
}
