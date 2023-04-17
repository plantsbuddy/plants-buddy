import 'dart:io';

import 'package:flutter/material.dart';

class PlantDetailsTwo extends StatelessWidget {
  const PlantDetailsTwo(this.plant, {Key? key}) : super(key: key);
  final Map<String, dynamic> plant;

  @override
  Widget build(BuildContext context) {
    final textThemes = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.file(
            File(plant['image']),
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
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                            Icons.short_text_outlined,
                            size: 17,
                            color: Theme.of(context).colorScheme.tertiaryContainer,
                          ),
                          SizedBox(width: 7),
                          Expanded(
                            child: Text(
                              'Common name',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
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
                        plant['order'],
                        style: textThemes.titleMedium,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.energy_savings_leaf,
                            size: 17,
                            color: Theme.of(context).colorScheme.tertiaryContainer,
                          ),
                          SizedBox(width: 7),
                          Text(
                            'Order',
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
        Text(
          plant['short_description'],
          style: textThemes.bodySmall,
        ),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plant['phylum'],
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
                          Expanded(
                            child: Text(
                              'Phylum',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plant['plant_class'],
                        style: textThemes.titleMedium,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.group_work,
                            size: 17,
                            color: Theme.of(context).colorScheme.tertiaryContainer,
                          ),
                          SizedBox(width: 7),
                          Text(
                            'Class',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plant['family'],
                        style: textThemes.titleMedium,
                        overflow: TextOverflow.clip,
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
                            'Family',
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
                      Icons.location_on_sharp,
                      size: 18,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Plant Habitat',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  plant['habitat'],
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
                      Icons.calendar_month,
                      size: 18,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Blooming Times',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  plant['blooming_times'],
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
                      Icons.share_location_outlined,
                      size: 18,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Plant Distribution',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  plant['distribution'],
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
