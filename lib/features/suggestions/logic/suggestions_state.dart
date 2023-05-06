part of 'suggestions_bloc.dart';

enum SuggestionsStatus { loading, loaded }

@immutable
class SuggestionsState extends Equatable {
  final List<PlantationGuide> plantationGuides;
  final SuggestionsStatus status;
  final Map<String, dynamic> weatherData;
  final List<dynamic> weatherBasedSuggestions;
  final List<dynamic> weatherBasedPlantSuggestions;
  final String currentWeatherPlantsType;
  final String tipOfTheDay;
  final bool tipOfTheDayLoaded;

  SuggestionsState.initial()
      : status = SuggestionsStatus.loading,
        weatherData = {},
        weatherBasedSuggestions = [],
        weatherBasedPlantSuggestions = [],
        currentWeatherPlantsType = '',
        tipOfTheDay = '',
        tipOfTheDayLoaded = false,
        plantationGuides = [];

  const SuggestionsState({
    required this.plantationGuides,
    required this.status,
    required this.weatherData,
    required this.tipOfTheDay,
    required this.weatherBasedSuggestions,
    required this.weatherBasedPlantSuggestions,
    required this.currentWeatherPlantsType,
    required this.tipOfTheDayLoaded,
  });

  SuggestionsState copyWith({
    bool? tipOfTheDayLoaded,
    List<PlantationGuide>? plantationGuides,
    SuggestionsStatus? status,
    Map<String, dynamic>? weatherData,
    List<dynamic>? weatherBasedSuggestions,
    List<dynamic>? weatherBasedPlantSuggestions,
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
        tipOfTheDayLoaded: tipOfTheDayLoaded ?? this.tipOfTheDayLoaded,
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
        tipOfTheDayLoaded,
      ];
}
