import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:plants_buddy/features/suggestions/domain/entities/plantation_guide.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

import '../domain/repositories/suggestions_service.dart';

class SuggestionsServiceImpl implements SuggestionsService {
  final http.Client client;

  SuggestionsServiceImpl() : client = http.Client();

  @override
  Future<List<PlantationGuide>> get plantationGuides async {
    final apiResponse = await client.get(Uri.parse('http://plants-buddy.herokuapp.com/plantation-guides'));

    final parsedResponse = jsonDecode(apiResponse.body);

    List<PlantationGuide> guides = [];

    for (Map<String, dynamic> guideMap in parsedResponse) {
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
    final apiResponse = await client.get(Uri.parse('http://plants-buddy.herokuapp.com/random-plantation-suggestion'));

    return apiResponse.body;
  }

  @override
  Future<List<dynamic>> get weatherBasedSuggestions async {
    final coordinates = await _determinePosition();

    final apiResponse = await client.post(
      Uri.parse('http://plants-buddy.herokuapp.com/weather-based-plantation-suggestions'),
      headers: {'Content-Type': 'application/json'},
      encoding: Encoding.getByName('utf-8'),
      body: jsonEncode({
        'longitude': coordinates['longitude'],
        'latitude': coordinates['latitude'],
      }),
    );

    final Map<String, dynamic> parsedResponse = jsonDecode(apiResponse.body);
    return parsedResponse['suggestions'];
  }

  @override
  Future<Map<String, dynamic>> get weatherBasedPlantSuggestions async {
    final coordinates = await _determinePosition();

    final apiResponse = await client.post(
      Uri.parse('http://plants-buddy.herokuapp.com/weather-based-suggested-plants'),
      headers: {'Content-Type': 'application/json'},
      encoding: Encoding.getByName('utf-8'),
      body: jsonEncode({
        'longitude': coordinates['longitude'],
        'latitude': coordinates['latitude'],
      }),
    );

    return jsonDecode(apiResponse.body);
  }

  @override
  Future<Map<String, dynamic>> get weatherData async {
    final coordinates = await _determinePosition();

    final apiResponse = await client.post(
      Uri.parse('http://plants-buddy.herokuapp.com/weather-data'),
      headers: {'Content-Type': 'application/json'},
      encoding: Encoding.getByName('utf-8'),
      body: jsonEncode({
        'longitude': coordinates['longitude'],
        'latitude': coordinates['latitude'],
      }),
    );

    // final res = jsonDecode(apiResponse.body) as Map<String, String>;
    // log(res['city'].runtimeType.toString());
    // log(res['humidity'].runtimeType.toString());
    // log(res['temperature'].runtimeType.toString());
    // log(res['weather_status_description'].runtimeType.toString());
    // log(res['weather_status_icon'].runtimeType.toString());
    // log(res['weather_status_title'].runtimeType.toString());
    // log(res['wind_speed'].runtimeType.toString());

    return jsonDecode(apiResponse.body);
  }

  Future<Map<String, String>> _determinePosition() async {
    return {"longitude": "73.0479", "latitude": "33.6844"};

    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final position = await Geolocator.getCurrentPosition();
    return {
      'longitude': position.longitude.toString(),
      'latitude': position.latitude.toString(),
    };
  }
}
