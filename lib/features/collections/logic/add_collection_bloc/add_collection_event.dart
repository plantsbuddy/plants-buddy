part of 'add_collection_bloc.dart';

@immutable
abstract class AddCollectionEvent {}

class AddCollectionButtonPressed extends AddCollectionEvent {
  final String cover, name;

  AddCollectionButtonPressed({required this.cover, required this.name});
}

class AddCollectionEditCollectionPressed extends AddCollectionEvent {
  final Collection originalCollection;

  AddCollectionEditCollectionPressed(this.originalCollection);
}

class AddCollectionEditCompleted extends AddCollectionEvent {}
