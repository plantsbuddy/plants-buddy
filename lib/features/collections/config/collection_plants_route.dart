import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../domain/entities/collection.dart';
import '../logic/collection_plants/collection_plants_bloc.dart';
import '../presentation/collection_plants_screen.dart';

MaterialPageRoute route(Object? collection) {
  final sl = GetIt.instance;

  collection as Collection;

  return MaterialPageRoute(
    builder: (_) {
      return BlocProvider<CollectionPlantsBloc>(
        create: (context) =>
            CollectionPlantsBloc(collection: collection, sl())..add(CollectionPlantsInitializePlantsStream()),
        child: CollectionPlantsScreen(),
      );
    },
  );
}
