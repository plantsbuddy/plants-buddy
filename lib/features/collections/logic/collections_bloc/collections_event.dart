part of 'collections_bloc.dart';

@immutable
abstract class CollectionsEvent {}

class CollectionsInitializeCollectionsStream extends CollectionsEvent {}

class CollectionsDeleteCollectionPressed extends CollectionsEvent {
  final Collection collection;

  CollectionsDeleteCollectionPressed(this.collection);
}
