import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/collections/logic/add_collection_bloc/add_plant_bloc.dart';
import 'package:plants_buddy/features/collections/presentation/add_plant_to_collection_screen.dart';

import '../domain/entities/collection.dart';
import '../logic/collection_plants/collection_plants_bloc.dart';
import '../presentation/collection_plants_screen.dart';

MaterialPageRoute route(Object? data) {
  final sl = GetIt.instance;

  data as Map<String, dynamic>;

  final Map<String, dynamic>? originalPlant = data['original_plant'];
  final Collection collection = data['collection'];

  return MaterialPageRoute(
    builder: (_) {
      return BlocProvider<AddPlantBloc>(
        create: (context) => AddPlantBloc(sl(), collection: collection, originalPlant: originalPlant),
        child: AddPlantToCollectionScreen(),
      );
    },
  );
}
