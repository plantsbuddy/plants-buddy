import 'package:flutter/material.dart';
import 'package:plants_buddy/features/identification/presentation/similar_images_slideshow.dart';

class DiseaseDetailsScreen extends StatelessWidget {
  const DiseaseDetailsScreen(this.disease, {Key? key}) : super(key: key);

  final Map<String, dynamic> disease;

  @override
  Widget build(BuildContext context) {
    final textThemes = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('${disease.keys.contains('disease_class') ? 'Disease' : 'Pest'} Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SimilarImagesSlideShow(disease['images']),
              ),
              SizedBox(height: 20),
              Text(
                'Scientific name',
                style: textThemes.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Text(
                disease['scientific_name'],
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
                              disease['name'],
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
                  SizedBox(width: 5),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              disease['disease_class'] ?? disease['pest_class'],
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
                                  'Disease class',
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
              SizedBox(height: 20),
              Text(
                'Host Plants',
                style: textThemes.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: 7),
              Wrap(
                children: [
                  ...disease['host_plants'].map(
                    (host) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Chip(
                        label: Text(
                          host,
                          style: textThemes.bodySmall,
                        ),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
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
                            Icons.visibility,
                            size: 18,
                            color: Theme.of(context).colorScheme.tertiaryContainer,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'In a Nutshell',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      ...disease['in_a_nutshell'].map(
                        (name) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '•',
                                style: textThemes.titleLarge,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  name,
                                  style: textThemes.bodyLarge,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                            Icons.warning_rounded,
                            size: 18,
                            color: Theme.of(context).colorScheme.tertiaryContainer,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Symptoms',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        disease['symptoms'],
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
                            Icons.call_missed_outgoing_sharp,
                            size: 18,
                            color: Theme.of(context).colorScheme.tertiaryContainer,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Causes',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        disease['causes'],
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.soup_kitchen_rounded,
                            size: 18,
                            color: Theme.of(context).colorScheme.tertiaryContainer,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Organic Control',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        disease['organic_control'],
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.assistant_photo,
                            size: 18,
                            color: Theme.of(context).colorScheme.tertiaryContainer,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Chemical Control',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        disease['chemical_control'],
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Preventive Measures',
                      style: textThemes.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    SizedBox(height: 15),
                    ...disease['preventive_measures'].map(
                      (measure) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '•',
                              style: textThemes.titleLarge,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                measure,
                                style: textThemes.bodyLarge,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
