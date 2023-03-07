import 'package:flutter/material.dart';

class SampleAppointmentItemBotanist extends StatelessWidget {
  const SampleAppointmentItemBotanist({Key? key}) : super(key: key);

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mohsin Ismail',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Plant pathology',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black54),
                    ),
                  ],
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
                    Text('27/03/2023'),
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
                    Text('6:00 AM'),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.circle_rounded,
                      size: 10,
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                    ),
                    SizedBox(width: 5),
                    Text('Pending'),
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
                      onPressed: () {},
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
                      onPressed: () {},
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
}
