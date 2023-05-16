import 'package:flutter/material.dart';

class SampleReportedComment extends StatelessWidget {
  const SampleReportedComment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Comment',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Title',
              style: TextStyle(color: Colors.black.withOpacity(0.75)),
            ),
            SizedBox(height: 10),
            Text(
              'Comment Author',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Description',
              style: TextStyle(color: Colors.black.withOpacity(0.75)),
            ),
            SizedBox(height: 10),
            Text(
              'Report',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Report',
              style: TextStyle(color: Colors.black.withOpacity(0.75)),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    foregroundColor: Theme.of(context).colorScheme.inverseSurface,
                    backgroundColor: Theme.of(context).colorScheme.inverseSurface.withOpacity(0.15),
                  ).copyWith(
                    elevation: ButtonStyleButton.allOrNull(0.0),
                  ),
                  onPressed: () {
                    // context.read<BotanistAppointmentBloc>().add(BotanistApproveAppointmentRequest(appointment));
                    //
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     content: Text('Appointment approved...'),
                    //     behavior: SnackBarBehavior.floating,
                    //     duration: Duration(milliseconds: 1500),
                    //   ),
                    // );
                  },
                  child: Text('Ignore'),
                ),
                SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  ).copyWith(
                    elevation: ButtonStyleButton.allOrNull(0.0),
                  ),
                  onPressed: () {
                    // context.read<BotanistAppointmentBloc>().add(BotanistApproveAppointmentRequest(appointment));
                    //
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     content: Text('Appointment approved...'),
                    //     behavior: SnackBarBehavior.floating,
                    //     duration: Duration(milliseconds: 1500),
                    //   ),
                    // );
                  },
                  child: Text('Block Author'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    foregroundColor: Theme.of(context).colorScheme.error,
                    backgroundColor: Theme.of(context).colorScheme.errorContainer,
                  ).copyWith(
                    elevation: ButtonStyleButton.allOrNull(0.0),
                  ),
                  onPressed: () {
                    // context.read<BotanistAppointmentBloc>().add(BotanistApproveAppointmentRequest(appointment));
                    //
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     content: Text('Appointment approved...'),
                    //     behavior: SnackBarBehavior.floating,
                    //     duration: Duration(milliseconds: 1500),
                    //   ),
                    // );
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
