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
    on<SuggestionsInitializeTipOfTheDay>(onSuggestionsInitializeTipOfTheDay);
    on<SuggestionsInitializeGuides>(onSuggestionsInitializeGuides);
  }

  FutureOr<void> onSuggestionsInitializeTipOfTheDay(
      SuggestionsInitializeTipOfTheDay event, Emitter<SuggestionsState> emit) async {
    final randomPlantationSuggestion = await _getRandomPlantationSuggestion();

    emit(state.copyWith(
      tipOfTheDay: randomPlantationSuggestion,
      tipOfTheDayLoaded: true,
    ));
  }

  FutureOr<void> onSuggestionsInitializeGuides(_, Emitter<SuggestionsState> emit) async {
    final weatherData = await _getWeatherData();
    emit(
      state.copyWith(
        weatherData: weatherData,
        weatherDataStatus: SuggestionsStatus.loaded,
      ),
    );

    final weatherBasedSuggestions = await _getWeatherBasedSuggestions();
    emit(
      state.copyWith(
        weatherBasedSuggestions: weatherBasedSuggestions,
        weatherBasedSuggestionsStatus: SuggestionsStatus.loaded,
      ),
    );

    final weatherBasedPlantSuggestions = await _getWeatherBasedPlantSuggestions();
    emit(state.copyWith(
      weatherBasedPlantSuggestions: weatherBasedPlantSuggestions['plants'],
      currentWeatherPlantsType: weatherBasedPlantSuggestions['weather_type'],
      weatherBasedPlantSuggestionsStatus: SuggestionsStatus.loaded,
    ));

    final plantationGuides = await _getPlantationGuides();
    emit(
      state.copyWith(
        plantationGuides: plantationGuides,
        plantationGuidesStatus: SuggestionsStatus.loaded,
      ),
    );
  }
}
