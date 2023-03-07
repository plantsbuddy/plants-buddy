import 'package:equatable/equatable.dart';

import 'plant.dart';

class Collection extends Equatable {
  final String name;
  final List<Plant> plants;

  const Collection({
    required this.name,
    required this.plants,
  });

  @override
  List<Object?> get props => [name, plants];
}
