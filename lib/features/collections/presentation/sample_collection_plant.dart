import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as routes;
import 'package:plants_buddy/features/collections/domain/entities/collection.dart';
import 'package:plants_buddy/features/collections/presentation/collection_plant_popup.dart';
import 'package:plants_buddy/features/identification/presentation/detail_pages/plant_one.dart';
import 'package:plants_buddy/features/identification/presentation/detail_pages/plant_three.dart';
import 'package:plants_buddy/features/identification/presentation/detail_pages/plant_two.dart';

import '../domain/entities/collection_plant.dart';

class SampleCollectionPlant extends StatelessWidget {
  const SampleCollectionPlant(this.plant, {Key? key}) : super(key: key);

  final CollectionPlant plant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                plant.details['images'][0],
                height: 150,
                width: 115,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plant.details['common_names'][0],
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        plant.details['scientific_name'],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black87),
                      ),
                      SizedBox(height: 10),
                      Text(
                        plant.details['description'],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black45),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CollectionPlantPopup(plant),
          ],
        ),
      ),
      onTap: () => Navigator.of(context).pushNamed(routes.plantDetails, arguments: plant.details),
    );
  }
}
