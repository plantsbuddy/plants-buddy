import 'dart:convert';

import 'package:plants_buddy/features/suggestions/domain/entities/plantation_guide.dart';
import 'package:http/http.dart' as http;

import '../domain/repositories/suggestions_service.dart';

class SuggestionsServiceImpl implements SuggestionsService {
  @override
  Future<List<PlantationGuide>> get plantationGuides async {
    final apiResponse = await http.get(Uri.parse('http://plants-buddy.herokuapp.com/'));

    final Map<String, dynamic> parsedResponse = jsonDecode(apiResponse.body);

    List<PlantationGuide> guides = [];

    for (Map<String, dynamic> guideMap in parsedResponse['guides']) {
      final PlantationGuide guide = PlantationGuide(
        cover: guideMap['cover'] as String,
        title: guideMap['title'] as String,
        guide: guideMap
          ..remove('cover')
          ..remove('title'),
      );

      guides.add(guide);
    }

    return guides;
  }

  @override
  Future<String> get randomPlantationSuggestion async {
    final apiResponse = await http.get(Uri.parse('http://plants-buddy.herokuapp.com/random-suggestion'));

    final parsedResponse = jsonDecode(apiResponse.body);
    return parsedResponse['suggestion'];
  }

  @override
  Future<List<String>> get weatherBasedSuggestions async {
    final apiResponse = await http.post(
      Uri.parse('http://plants-buddy.herokuapp.com/weather-based-plantation-suggestions'),
      headers: {'Content-Type': 'application/json'},
      encoding: Encoding.getByName('utf-8'),
      body: jsonEncode({
        'longitude': 'card',
        'latitude': 'card',
      }),
    );

    final Map<String, dynamic> parsedResponse = jsonDecode(apiResponse.body);
    return parsedResponse['suggestions'];
  }

  @override
  Future<List<String>> get weatherBasedPlantSuggestions async {
    final apiResponse = await http.post(
      Uri.parse('http://plants-buddy.herokuapp.com/weather-based-suggested-plants'),
      headers: {'Content-Type': 'application/json'},
      encoding: Encoding.getByName('utf-8'),
      body: jsonEncode({
        'longitude': 'card',
        'latitude': 'card',
      }),
    );

    final Map<String, dynamic> parsedResponse = jsonDecode(apiResponse.body);
    return parsedResponse['suggested_plants'];
  }

  @override
  Future<Map<String, String>> get weatherData async {
    final apiResponse = await http.post(
      Uri.parse('http://plants-buddy.herokuapp.com/weather-data'),
      headers: {'Content-Type': 'application/json'},
      encoding: Encoding.getByName('utf-8'),
      body: jsonEncode({
        'longitude': 'card',
        'latitude': 'card',
      }),
    );

    return jsonDecode(apiResponse.body);
  }
}
