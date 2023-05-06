import 'package:equatable/equatable.dart';

class Collection extends Equatable {
  final String? id;
  final String cover;
  final String name;

  //final List<Map<String, dynamic>> plants;

  const Collection({
    this.id,
    required this.cover,
    required this.name,
    //this.plants = const [],
  });

  Collection copyWith({
    String? id,
    String? cover,
    String? name,
    //List<Map<String, dynamic>>? plants,
  }) =>
      Collection(
        id: id ?? this.id,
        cover: cover ?? this.cover,
        name: name ?? this.name,
        //plants: plants ?? this.plants,
      );

  @override
  List<Object?> get props => [
        id,
        cover,
        name,
        // plants,
      ];
}
