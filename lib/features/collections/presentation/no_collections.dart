import 'package:flutter/material.dart';
import 'package:plants_buddy/core/utils/custom_icons.dart' as custom_icons;

class NoCollections extends StatelessWidget {
  const NoCollections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 50),
        Image.asset(
          custom_icons.noCollections,
          height: 100,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Text(
            'No Collections',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Text(
          'Click the + button to create a new plants collections, and add plants into it',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
