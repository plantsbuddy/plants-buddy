part of 'suggestions_bloc.dart';

enum SuggestionsStatus { loading, loaded }

@immutable
class SuggestionsState extends Equatable {
  final List<PlantationGuide> plantationGuides;
  final SuggestionsStatus status;
  final Map<String, String> weatherData;
  final List<String> weatherBasedSuggestions;
  final List<String> weatherBasedPlantSuggestions;
  final String currentWeatherPlantsType;
  final String tipOfTheDay;

  SuggestionsState.initial()
      : status = SuggestionsStatus.loading,
        weatherData = {},
        weatherBasedSuggestions = [],
        weatherBasedPlantSuggestions = [],
        currentWeatherPlantsType = '',
        tipOfTheDay = '',
        plantationGuides = [];

  const SuggestionsState({
    required this.plantationGuides,
    required this.status,
    required this.weatherData,
    required this.tipOfTheDay,
    required this.weatherBasedSuggestions,
    required this.weatherBasedPlantSuggestions,
    required this.currentWeatherPlantsType,
  });

  SuggestionsState copyWith({
    List<PlantationGuide>? plantationGuides,
    SuggestionsStatus? status,
    Map<String, String>? weatherData,
    List<String>? weatherBasedSuggestions,
    List<String>? weatherBasedPlantSuggestions,
    String? currentWeatherPlantsType,
    String? tipOfTheDay,
  }) =>
      SuggestionsState(
        plantationGuides: plantationGuides ?? this.plantationGuides,
        status: status ?? this.status,
        weatherData: weatherData ?? this.weatherData,
        tipOfTheDay: tipOfTheDay ?? this.tipOfTheDay,
        weatherBasedSuggestions: weatherBasedSuggestions ?? this.weatherBasedSuggestions,
        weatherBasedPlantSuggestions: weatherBasedPlantSuggestions ?? this.weatherBasedPlantSuggestions,
        currentWeatherPlantsType: currentWeatherPlantsType ?? this.currentWeatherPlantsType,
      );

  @override
  List<Object?> get props => [
        status,
        tipOfTheDay,
        plantationGuides,
        weatherBasedPlantSuggestions,
        weatherBasedSuggestions,
        weatherData,
        currentWeatherPlantsType,
      ];
}
