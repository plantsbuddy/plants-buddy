part of 'add_collection_bloc.dart';

@immutable
class AddCollectionState extends Equatable {
  final String name;
  final String cover;
  final Collection? originalCollection;

  const AddCollectionState({
    required this.name,
    required this.cover,
    this.originalCollection,
  });

  AddCollectionState.create()
      : name = '',
        cover = '',
        originalCollection = null;

  AddCollectionState.update(this.originalCollection)
      : name = originalCollection!.name,
        cover = originalCollection.cover;

  AddCollectionState copyWith({
    String? name,
    String? cover,
    Collection? Function()? originalCollection,
  }) =>
      AddCollectionState(
        name: name ?? this.name,
        cover: cover ?? this.cover,
        originalCollection: originalCollection == null ? this.originalCollection : originalCollection(),
      );

  @override
  List<Object?> get props => [name, cover, originalCollection];
}
