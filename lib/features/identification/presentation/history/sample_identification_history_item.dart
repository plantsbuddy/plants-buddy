import 'package:flutter/material.dart';
import 'package:plants_buddy/features/identification/domain/entities/identification_history_item.dart';

class SampleIdentificationHistoryItem extends StatelessWidget {
  const SampleIdentificationHistoryItem(this.historyItem, {Key? key}) : super(key: key);

  final IdentificationHistoryItem historyItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.network(
                historyItem.imageUrl,
                width: 100,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  historyItem.firstMatch,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge,
                ),
                Text(
                  historyItem.formattedTime,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 10)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
