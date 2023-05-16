import 'package:flutter/material.dart';

class SampleBlockedUser extends StatelessWidget {
  const SampleBlockedUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image.network(
                    'http://103.139.122.252/data/images/default-user.png',
                    fit: BoxFit.cover,
                    width: 55,
                    height: 55,
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mohsin',
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'mohsin@gmail.com',
                      style: TextStyle(color: Theme.of(context).dividerColor.withOpacity(0.5)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Gardener',
                      style: TextStyle(color: Theme.of(context).dividerColor.withOpacity(0.5)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                  child: Text('Unblock'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
