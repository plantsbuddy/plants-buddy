import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../domain/entities/plantation_guide.dart';
import '../domain/usecases/suggestions_usecases.dart';

part 'suggestions_event.dart';

part 'suggestions_state.dart';

class SuggestionsBloc extends Bloc<SuggestionsEvent, SuggestionsState> {
  final GetPlantationGuides _getPlantationGuides;
  final GetRandomPlantationSuggestion _getRandomPlantationSuggestion;
  final GetWeatherData _getWeatherData;
  final GetWeatherBasedSuggestions _getWeatherBasedSuggestions;
  final GetWeatherBasedPlantSuggestions _getWeatherBasedPlantSuggestions;

  SuggestionsBloc(
    this._getPlantationGuides,
    this._getRandomPlantationSuggestion,
    this._getWeatherData,
    this._getWeatherBasedSuggestions,
    this._getWeatherBasedPlantSuggestions,
  ) : super(SuggestionsState.initial()) {
    on<SuggestionsInitializeGuides>(onSuggestionsInitializeGuides);
  }

  FutureOr<void> onSuggestionsInitializeGuides(_, Emitter<SuggestionsState> emit) async {
    final plantationGuides = await _getPlantationGuides();
    final randomPlantationSuggestions = await _getRandomPlantationSuggestion();
    final weatherData = await _getWeatherData();
    final weatherBasedSuggestions = await _getWeatherBasedSuggestions();
    final weatherBasedPlantSuggestions = await _getWeatherBasedPlantSuggestions();

    emit(state.copyWith(
      status: SuggestionsStatus.loaded,
      plantationGuides: plantationGuides,
      tipOfTheDay: randomPlantationSuggestions,
      weatherData: weatherData,
      weatherBasedPlantSuggestions: weatherBasedPlantSuggestions,
      weatherBasedSuggestions: weatherBasedSuggestions,
    ));
  }
}
