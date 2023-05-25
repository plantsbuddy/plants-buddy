import 'package:flutter/material.dart';
import 'package:plants_buddy/features/suggestions/domain/entities/plantation_guide.dart';

class FullGuideScreen extends StatelessWidget {
  const FullGuideScreen(this.guide, {Key? key}) : super(key: key);

  final PlantationGuide guide;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plantation Guide'),),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 17,right:17, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: double.infinity,
                        child: Image.network(
                          guide.cover,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    guide.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  ...guide.guide.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Builder(
                        builder: (context) {
                          if (entry.key.contains('image')) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Image.network(
                                    entry.value as String,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          } else if (entry.key.contains('h1')) {
                            return Text(
                              entry.value as String,
                              style: Theme.of(context).textTheme.headlineSmall,
                            );
                          } else if (entry.key.contains('text')) {
                            return Text(
                              entry.value as String,
                              style: TextStyle(fontSize: 15, height: 1.3),
                            );
                          } else if (entry.key.contains('h3')) {
                            return Text(
                              '●  ${entry.value}',
                              style: Theme.of(context).textTheme.titleMedium,
                            );
                          } else if (entry.key.contains('h2')) {
                            return Text(
                              entry.value as String,
                              style: Theme.of(context).textTheme.titleLarge,
                            );
                          } else if (entry.key.contains('ul')) {
                            final list = entry.value as List<dynamic>;
                            return Column(
                              children: list.map((item) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${list.indexOf(item) + 1}. ',
                                        style: Theme.of(context).textTheme.labelLarge,
                                      ),
                                      Expanded(child: Text(item)),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          }

                          return Container();
                        },
                      ),
                    );
                  }).toList()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
