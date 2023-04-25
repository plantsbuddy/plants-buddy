import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as routes;
import 'package:plants_buddy/features/collections/domain/entities/collection.dart';

class SampleCollectionPlant extends StatelessWidget {
  const SampleCollectionPlant(this.plant, {Key? key}) : super(key: key);

  final Map<String, dynamic> plant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(routes.collectionPlants),
      child: Card(
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(120),
            child: Image.network(
              'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/109354797/original/db7435d5305bb7b8a843e405af7d00952c82f9a3/implement-android-ui-design-in-xml.png',
              width: 60,
              height: 60,
              fit: BoxFit.fitHeight,
            ),
          ),
          title: Text('Cabula Oscura'),
          subtitle: Text('Ovata'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
      ),
    );
  }
}
