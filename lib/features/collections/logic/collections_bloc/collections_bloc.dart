import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/collection.dart';
import '../../domain/usecases/collections_usecases.dart';

part 'collections_event.dart';

part 'collections_state.dart';

class CollectionsBloc extends Bloc<CollectionsEvent, CollectionsState> {
  final GetCollectionsStream _getCollectionsStream;
  final DeleteCollection _deleteCollection;

  CollectionsBloc(this._getCollectionsStream, this._deleteCollection) : super(CollectionsState.initial()) {
    on<CollectionsInitializeCollectionsStream>(onCollectionsInitializeCollectionsStream);
    on<CollectionsDeleteCollectionPressed>(onCollectionsDeleteCollectionPressed);
  }

  Future<FutureOr<void>> onCollectionsInitializeCollectionsStream(
      CollectionsInitializeCollectionsStream event, Emitter<CollectionsState> emit) async {
    final collectionsStream = await _getCollectionsStream();

    await emit.forEach(
      collectionsStream,
      onData: (collections) => state.copyWith(collections: collections, status: CollectionsStatus.loaded),
    );
  }

  Future<FutureOr<void>> onCollectionsDeleteCollectionPressed(
      CollectionsDeleteCollectionPressed event, Emitter<CollectionsState> emit) async {
    await _deleteCollection(event.collection);
  }
}
