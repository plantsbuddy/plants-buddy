import 'dart:io';

import 'package:flutter/material.dart';

import '../similar_images_slideshow.dart';

class PlantDetailsOne extends StatelessWidget {
  const PlantDetailsOne(this.plant, {Key? key}) : super(key: key);

  final Map<String, dynamic> plant;

  @override
  Widget build(BuildContext context) {
    final textThemes = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: SimilarImagesSlideShow(plant['images']),
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
        SizedBox(height: 15),
        Text(
          'Common names',
          style: textThemes.bodySmall!.copyWith(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        SizedBox(height: 5),
        ...plant['common_names'].map(
          (name) => Row(
            children: [
              Row(
                children: [
                  Text(
                    '•',
                    style: textThemes.titleLarge,
                  ),
                  SizedBox(width: 10),
                  Text(
                    name,
                    style: textThemes.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Leaf Color',
              style: textThemes.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Text(
              plant['leaf_color'],
              style: textThemes.bodyLarge,
            ),
          ],
        ),
        SizedBox(height: 15),
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
                        plant['genus'],
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
                            'Genus',
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
                        plant['species'],
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
                            'Species',
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
        SizedBox(height: 15),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.sunny,
                      size: 18,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Light Conditions',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  plant['light'],
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
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
                      Icons.soup_kitchen,
                      size: 18,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Soil Drainage',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                ...plant['soil_drainage'].map(
                  (drainage) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '•',
                        style: textThemes.titleLarge,
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          drainage,
                          style: textThemes.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
