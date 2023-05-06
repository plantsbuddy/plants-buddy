import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/collection.dart';
import '../../domain/entities/collection_plant.dart';
import '../../domain/usecases/collections_usecases.dart';

part 'collection_plants_event.dart';

part 'collection_plants_state.dart';

class CollectionPlantsBloc extends Bloc<CollectionPlantsEvent, CollectionPlantsState> {
  final GetCollectionPlantsStream _getCollectionPlantsStream;
  final DeletePlantFromCollection _deletePlantFromCollection;

  CollectionPlantsBloc(this._getCollectionPlantsStream, this._deletePlantFromCollection,
      {required Collection collection})
      : super(CollectionPlantsState.initial(collection)) {
    on<CollectionPlantsInitializePlantsStream>(onCollectionPlantsInitializePlantsStream);
    on<CollectionPlantsDeletePlantPressed>(onCollectionPlantsDeletePlantPressed);
  }

  Future<FutureOr<void>> onCollectionPlantsInitializePlantsStream(
      CollectionPlantsInitializePlantsStream event, Emitter<CollectionPlantsState> emit) async {
    final plantsStream = await _getCollectionPlantsStream(state.collection);

    await emit.forEach(
      plantsStream,
      onData: (plants) => state.copyWith(plants: plants, status: CollectionPlantsStatus.loaded),
    );
  }

  FutureOr<void> onCollectionPlantsDeletePlantPressed(
      CollectionPlantsDeletePlantPressed event, Emitter<CollectionPlantsState> emit) async {
    await _deletePlantFromCollection(plant: event.plant, collection: state.collection);
  }
}
