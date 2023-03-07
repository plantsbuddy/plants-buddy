import 'package:equatable/equatable.dart';

class Plant extends Equatable {
  final String name;

  const Plant({required this.name});

  @override
  List<Object?> get props => [name];
}
