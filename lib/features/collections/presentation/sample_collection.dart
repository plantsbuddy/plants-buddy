import 'package:flutter/material.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as app_routes;
import 'package:plants_buddy/features/collections/domain/entities/collection.dart';

import 'collection_popup.dart';

class SampleCollection extends StatelessWidget {
  const SampleCollection(this.collection, {Key? key}) : super(key: key);

  final Collection collection;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.network(
                collection.cover,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey.withOpacity(0.1),
                      Colors.grey.withOpacity(0.6),
                      Colors.grey.withOpacity(0.7),
                      Colors.grey.withOpacity(0.8),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Positioned(
                  bottom: 0,
                  left: 0,
                  right: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      collection.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white.withOpacity(0.9)),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: CollectionPopup(collection),
            ),
          ],
        ),
      ),
      onTap: () => Navigator.of(context).pushNamed(app_routes.collectionPlants, arguments: collection),
    );
  }
}
