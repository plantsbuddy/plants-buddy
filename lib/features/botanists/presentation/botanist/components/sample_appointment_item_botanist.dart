import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/botanists/domain/entities/appointment.dart';
import 'package:plants_buddy/features/botanists/logic/botanist_appointment_bloc/botanist_appointment_bloc.dart';

class SampleAppointmentItemBotanist extends StatelessWidget {
  const SampleAppointmentItemBotanist(this.appointment, {Key? key}) : super(key: key);

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 7),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(120),
                  child: Image.network(
                    'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/109354797/original/db7435d5305bb7b8a843e405af7d00952c82f9a3/implement-android-ui-design-in-xml.png',
                    width: 45,
                    height: 45,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.botanist.username,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        appointment.notes,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black54),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 1,
              thickness: 0.1,
              color: Colors.black45,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 20,
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                    ),
                    SizedBox(width: 5),
                    Text(appointment.formattedDate),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_filled,
                      size: 20,
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                    ),
                    SizedBox(width: 5),
                    Text(appointment.formattedTime),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.circle_rounded,
                      size: 10,
                      color: _getStatusColor(context),
                    ),
                    SizedBox(width: 5),
                    Text(_getStatusText()),
                  ],
                ),
              ],
            ),
            if (true)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        foregroundColor: Theme.of(context).colorScheme.error,
                        backgroundColor: Theme.of(context).colorScheme.errorContainer,
                      ).copyWith(
                        elevation: ButtonStyleButton.allOrNull(0.0),
                      ),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text('Confirm rejection'),
                            content: Text('Are you sure you want to reject this appointment request?'),
                            actions: [
                              TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel')),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<BotanistAppointmentBloc>()
                                      .add(BotanistRejectAppointmentRequest(appointment));
                                  Navigator.of(context).pop();
                                },
                                child: Text('Reject'),
                                style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                              ),
                            ],
                          );
                        },
                      ),
                      child: Text('Reject'),
                    ),
                    SizedBox(width: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        foregroundColor: Theme.of(context).colorScheme.tertiary,
                        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                      ).copyWith(
                        elevation: ButtonStyleButton.allOrNull(0.0),
                      ),
                      onPressed: () {
                        context.read<BotanistAppointmentBloc>().add(BotanistApproveAppointmentRequest(appointment));

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Appointment approved...'),
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(milliseconds: 1500),
                          ),
                        );
                      },
                      child: Text('Approve'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(BuildContext context) {
    switch (appointment.status) {
      case AppointmentStatus.pending:
        return Colors.brown;
      case AppointmentStatus.scheduled:
        return Colors.orangeAccent;
      case AppointmentStatus.completed:
        return Theme.of(context).colorScheme.primary.withOpacity(0.8);
      case AppointmentStatus.cancelled:
        return Theme.of(context).colorScheme.error.withOpacity(0.6);
      case AppointmentStatus.rejected:
        return Theme.of(context).colorScheme.error.withOpacity(0.6);
    }
  }

  String _getStatusText() {
    switch (appointment.status) {
      case AppointmentStatus.pending:
        return 'Pending';
      case AppointmentStatus.scheduled:
        return 'Scheduled';
      case AppointmentStatus.completed:
        return 'Completed';
      case AppointmentStatus.cancelled:
        return 'Cancelled';
      case AppointmentStatus.rejected:
        return 'Rejected';
    }
  }
}
