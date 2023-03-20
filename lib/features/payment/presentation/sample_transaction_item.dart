import 'package:flutter/material.dart';

class SampleTransactionItem extends StatelessWidget {
  const SampleTransactionItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        child: Row(
          children: [
            Text(
              '\$',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              '5',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Paid to',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).hintColor),
                ),
                Text('Mohsin Ismail', style: Theme.of(context).textTheme.titleSmall),
                Text(
                  'for consultation',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).hintColor),
                ),
              ],
            ),
            Spacer(),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                '15 March, 2023',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
