import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/collection.dart';
import '../../domain/entities/collection_plant.dart';
import '../../domain/usecases/collections_usecases.dart';

part 'add_plant_event.dart';

part 'add_plant_state.dart';

class AddPlantBloc extends Bloc<AddPlantEvent, AddPlantState> {
  final UpdatePlantInCollection _addPlantToCollection;

  AddPlantBloc(this._addPlantToCollection, {required Collection collection, CollectionPlant? originalPlant})
      : super(originalPlant == null
            ? AddPlantState.create(collection)
            : AddPlantState.update(collection: collection, originalPlant: originalPlant)) {
    on<AddPlantSubmitButtonPressed>(onAddPlantSubmitButtonPressed);
  }

  FutureOr<void> onAddPlantSubmitButtonPressed(AddPlantSubmitButtonPressed event, Emitter<AddPlantState> emit) async {
    await _addPlantToCollection(
      imagePath: event.image,
      collection: state.collection,
      commonNames: event.commonNames,
      scientificName: event.scientificName,
      leafColor: event.leafColor,
      genus: event.genus,
      species: event.species,
      family: event.family,
      description: event.description,
      lightConditions: event.lightConditions,
      soilDrainage: event.soilDrainage,
      originalPlant: state.originalPlant,
    );
  }
}
