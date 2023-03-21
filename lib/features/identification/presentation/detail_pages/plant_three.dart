import 'package:flutter/material.dart';

class PlantDetailsThree extends StatelessWidget {
  const PlantDetailsThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textThemes = Theme.of(context).textTheme;
    final plant = {};
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            'https://www.clearwaycommunitysolar.com/wp-content/uploads/2019/03/iStock-956366756-1024x683.jpg',
            height: 250,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Scientific name',
          style: textThemes.bodySmall!.copyWith(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        Text(
          plant['scientific_name'],
          style: textThemes.headlineSmall,
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plant['common_name'],
                        style: textThemes.titleMedium,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.spa,
                            size: 17,
                            color: Theme.of(context).colorScheme.tertiaryContainer,
                          ),
                          SizedBox(width: 7),
                          Text(
                            'Common name',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plant['category'],
                        style: textThemes.titleMedium,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.bubble_chart,
                            size: 17,
                            color: Theme.of(context).colorScheme.tertiaryContainer,
                          ),
                          SizedBox(width: 7),
                          Text(
                            'Category',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.description,
                      size: 18,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  plant['description'],
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.ac_unit,
                      size: 18,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Flowers',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  plant['flowers'],
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.energy_savings_leaf,
                      size: 18,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Leaves',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  plant['leaves'],
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.grain,
                      size: 18,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Fruits Seeds',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  plant['fruits_seeds'],
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
