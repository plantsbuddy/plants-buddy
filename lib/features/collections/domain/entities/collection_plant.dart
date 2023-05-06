import 'package:equatable/equatable.dart';

class CollectionPlant extends Equatable {
  final String? id;

  //final int website;
  final Map<String, dynamic> details;

  const CollectionPlant({
    this.id,
    //  required this.website,
    required this.details,
  });

  CollectionPlant copyWith({
    String? id,
    Map<String, dynamic>? details,
  }) =>
      CollectionPlant(
        details: details ?? this.details,
        id: id ?? this.id,
      );

  @override
  List<Object?> get props => [id, details];
}
