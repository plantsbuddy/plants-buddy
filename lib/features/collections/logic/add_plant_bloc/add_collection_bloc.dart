import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/collection.dart';
import '../../domain/usecases/collections_usecases.dart';

part 'add_collection_event.dart';

part 'add_collection_state.dart';

class AddCollectionBloc extends Bloc<AddCollectionEvent, AddCollectionState> {
  final AddCollection _addCollection;

  AddCollectionBloc(this._addCollection) : super(AddCollectionState.create()) {
    on<AddCollectionButtonPressed>(onAddCollectionButtonPressed);
    on<AddCollectionEditCollectionPressed>(onAddCollectionEditCollectionPressed);
  }

  Future<FutureOr<void>> onAddCollectionButtonPressed(
      AddCollectionButtonPressed event, Emitter<AddCollectionState> emit) async {
    await _addCollection(name: event.name, cover: event.cover);
  }

  FutureOr<void> onAddCollectionEditCollectionPressed(
      AddCollectionEditCollectionPressed event, Emitter<AddCollectionState> emit) {
    emit(state.copyWith(
        originalCollection: () => event.originalCollection,
        name: event.originalCollection.name,
        cover: event.originalCollection.cover));
  }
}
