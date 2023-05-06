import 'package:plants_buddy/features/suggestions/domain/entities/plantation_guide.dart';

abstract class SuggestionsService {
  Future<List<PlantationGuide>> get plantationGuides;

  Future<List<dynamic>> get weatherBasedSuggestions;

  Future<Map<String, dynamic>> get weatherBasedPlantSuggestions;

  Future<Map<String, dynamic>> get weatherData;

  Future<String> get randomPlantationSuggestion;
}
