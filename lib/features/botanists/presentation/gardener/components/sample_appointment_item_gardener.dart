import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/botanists/logic/gardener_appointment_bloc/gardener_appointment_bloc.dart';
import 'package:plants_buddy/features/payment/logic/payment_bloc.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../domain/entities/appointment.dart';

class SampleAppointmentItemGardener extends StatelessWidget {
  const SampleAppointmentItemGardener(this.appointment, {Key? key}) : super(key: key);

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 7),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(120),
                  child: Image.network(
                    appointment.botanist.profilePicture,
                    width: 45,
                    height: 45,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(width: 15),
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
            SizedBox(height: 15),
            if (appointment.status == AppointmentStatus.completed) _getMinutesWidget(context),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: _getButton(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getButton(BuildContext context) {
    switch (appointment.status) {
      case AppointmentStatus.pending:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
          ).copyWith(
            elevation: ButtonStyleButton.allOrNull(0.0),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text('Confirm cancellation'),
                  content: Text('Are you sure you want to cancel this appointment request?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Back')),
                    TextButton(
                      onPressed: () {
                        context.read<GardenerAppointmentBloc>().add(GardenerCancelAppointmentRequest(appointment));
                        Navigator.of(context).pop();
                      },
                      child: Text('I\'m sure'),
                      style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                    ),
                  ],
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text('Cancel'),
          ),
        );
      case AppointmentStatus.scheduled:
        return appointment.isDue
            ? ZegoSendCallInvitationButton(
                isVideoCall: true,
                invitees: [ZegoUIKitUser(id: appointment.botanist.uid, name: appointment.botanist.username)],
                resourceID: "zegouikit_call",
                iconSize: const Size(40, 40),
                buttonSize: const Size(50, 50),
                // clickableBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
                icon: ButtonIcon(
                  icon: Icon(
                    Icons.videocam_rounded,
                    color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                ),
                verticalLayout: false,
                onPressed: (_, __, ___) => context.read<PaymentBloc>().add(PaymentChangeLastAppointment(appointment)),
              )
            : GestureDetector(
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Icon(
                    Icons.videocam_rounded,
                    size: 26,
                    color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
                  ),
                ),
                onTap: () => showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text('Slot not due'),
                      content: Text(
                          'Your appointment slot time is not due yet. You can only start the appointment between ${appointment.formattedTime} and ${appointment.endTimeFormatted} on ${appointment.formattedDate}.'),
                      actions: [
                        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Okay')),
                      ],
                    );
                  },
                ),
              );

      case AppointmentStatus.completed:
      case AppointmentStatus.cancelled:
      case AppointmentStatus.rejected:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
          ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text('Confirm deletion'),
                  content: Text('Are you sure you want to delete this appointment request?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Back')),
                    TextButton(
                      onPressed: () {
                        context.read<GardenerAppointmentBloc>().add(GardenerDeleteAppointmentRequest(appointment));
                        Navigator.of(context).pop();
                      },
                      child: Text('Delete'),
                      style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                    ),
                  ],
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text('Delete'),
          ),
        );
    }
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

  Widget _getMinutesWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Appointment minutes:',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(height: 3),
        Text(
          appointment.minutes!.isEmpty ? 'N/A' : appointment.minutes!,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
