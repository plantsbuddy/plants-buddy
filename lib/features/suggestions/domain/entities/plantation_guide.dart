import 'package:equatable/equatable.dart';

class PlantationGuide extends Equatable {
  final String cover;
  final String title;
  final Map<String, dynamic> guide;

  const PlantationGuide({
    required this.cover,
    required this.title,
    required this.guide,
  });

  @override
  List<Object?> get props => [cover, title, guide];
}
