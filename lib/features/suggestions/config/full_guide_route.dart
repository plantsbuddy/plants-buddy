import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:plants_buddy/features/suggestions/domain/entities/plantation_guide.dart';
import 'package:plants_buddy/features/suggestions/presentation/full_guide_screen.dart';

MaterialPageRoute route(Object? plantationGuide) {
  final sl = GetIt.instance;

  plantationGuide as PlantationGuide;

  return MaterialPageRoute(
    builder: (_) => FullGuideScreen(plantationGuide),
  );
}
