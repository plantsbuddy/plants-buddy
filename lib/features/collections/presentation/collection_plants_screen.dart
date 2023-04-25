import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as app_routes;

import '../logic/collection_plants/collection_plants_bloc.dart';
import 'no_collection_plants.dart';
import 'sample_collection_plant.dart';

class CollectionPlantsScreen extends StatelessWidget {
  const CollectionPlantsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CollectionPlantsBloc>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text(state.collection.name),
      ),
      body: Builder(
        builder: (context) {
          switch (state.status) {
            case CollectionPlantsStatus.loading:
              return Center(child: CircularProgressIndicator());
            case CollectionPlantsStatus.loaded:
              return state.collection.plants.isNotEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      itemBuilder: (context, index) {
                        return SampleCollectionPlant(state.collection.plants[index]);
                      },
                      itemCount: state.collection.plants.length,
                    )
                  : NoCollectionPlants();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed(
          app_routes.addPlantToCollection,
          arguments: {'collection': state.collection},
        ),
      ),
    );
  }
}
