import 'package:flutter/material.dart';

import '../domain/entities/collection.dart';
import '../domain/entities/plant.dart';

class CollectionPlantsScreen extends StatelessWidget {
  const CollectionPlantsScreen({Key? key}) : super(key: key);

  // const CollectionPlantsScreen(this._collection, {Key? key}) : super(key: key);

  //final Collection _collection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fragrant plants'), //Text(_collection.name),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemBuilder: (context, index) {
          //final Plant plant = _collection.plants[index];
          return Card(
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
          );
        },
        itemCount: 10, //_collection.plants.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
