import 'package:plants_buddy/features/suggestions/domain/entities/plantation_guide.dart';

abstract class SuggestionsService {
  Future<List<PlantationGuide>> get plantationGuides;

  Future<List<String>> get weatherBasedSuggestions;

  Future<List<String>> get weatherBasedPlantSuggestions;

  Future<Map<String, String>> get weatherData;

  Future<String> get randomPlantationSuggestion;
}
