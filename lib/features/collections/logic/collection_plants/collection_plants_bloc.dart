import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/collection.dart';
import '../../domain/usecases/collections_usecases.dart';

part 'collection_plants_event.dart';

part 'collection_plants_state.dart';

class CollectionPlantsBloc extends Bloc<CollectionPlantsEvent, CollectionPlantsState> {
  final GetCollectionPlantsStream _getCollectionPlantsStream;

  CollectionPlantsBloc(this._getCollectionPlantsStream, {required Collection collection})
      : super(CollectionPlantsState.initial(collection)) {
    on<CollectionPlantsInitializePlantsStream>(onCollectionPlantsInitializePlantsStream);
  }

  Future<FutureOr<void>> onCollectionPlantsInitializePlantsStream(
      CollectionPlantsInitializePlantsStream event, Emitter<CollectionPlantsState> emit) async {
    final plantsStream = await _getCollectionPlantsStream(state.collection);

    await emit.forEach(
      plantsStream,
      onData: (plants) => state.copyWith(plants: plants, status: CollectionPlantsStatus.loaded),
    );
  }
}
