part of 'suggestions_bloc.dart';

enum SuggestionsStatus { loading, loaded }

@immutable
class SuggestionsState extends Equatable {
  final List<PlantationGuide> plantationGuides;
  final SuggestionsStatus plantationGuidesStatus;
  final Map<String, dynamic> weatherData;
  final SuggestionsStatus weatherDataStatus;
  final List<dynamic> weatherBasedSuggestions;
  final SuggestionsStatus weatherBasedSuggestionsStatus;
  final List<dynamic> weatherBasedPlantSuggestions;
  final SuggestionsStatus weatherBasedPlantSuggestionsStatus;
  final String currentWeatherPlantsType;
  final String tipOfTheDay;
  final bool tipOfTheDayLoaded;

  SuggestionsState.initial()
      : plantationGuidesStatus = SuggestionsStatus.loading,
        weatherData = {},
        weatherDataStatus = SuggestionsStatus.loading,
        weatherBasedSuggestions = [],
        weatherBasedSuggestionsStatus = SuggestionsStatus.loading,
        weatherBasedPlantSuggestions = [],
        weatherBasedPlantSuggestionsStatus = SuggestionsStatus.loading,
        currentWeatherPlantsType = '',
        tipOfTheDay = '',
        tipOfTheDayLoaded = false,
        plantationGuides = [];

  const SuggestionsState({
    required this.plantationGuides,
    required this.plantationGuidesStatus,
    required this.weatherDataStatus,
    required this.weatherBasedSuggestionsStatus,
    required this.weatherBasedPlantSuggestionsStatus,
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
    SuggestionsStatus? plantationGuidesStatus,
    SuggestionsStatus? status,
    Map<String, dynamic>? weatherData,
    SuggestionsStatus? weatherDataStatus,
    List<dynamic>? weatherBasedSuggestions,
    SuggestionsStatus? weatherBasedSuggestionsStatus,
    List<dynamic>? weatherBasedPlantSuggestions,
    SuggestionsStatus? weatherBasedPlantSuggestionsStatus,
    String? currentWeatherPlantsType,
    String? tipOfTheDay,
  }) =>
      SuggestionsState(
        plantationGuides: plantationGuides ?? this.plantationGuides,
        plantationGuidesStatus: plantationGuidesStatus ?? this.plantationGuidesStatus,
        weatherDataStatus: weatherDataStatus ?? this.weatherDataStatus,
        weatherBasedSuggestionsStatus: weatherBasedSuggestionsStatus ?? this.weatherBasedSuggestionsStatus,
        weatherBasedPlantSuggestionsStatus:
            weatherBasedPlantSuggestionsStatus ?? this.weatherBasedPlantSuggestionsStatus,
        weatherData: weatherData ?? this.weatherData,
        tipOfTheDay: tipOfTheDay ?? this.tipOfTheDay,
        weatherBasedSuggestions: weatherBasedSuggestions ?? this.weatherBasedSuggestions,
        weatherBasedPlantSuggestions: weatherBasedPlantSuggestions ?? this.weatherBasedPlantSuggestions,
        currentWeatherPlantsType: currentWeatherPlantsType ?? this.currentWeatherPlantsType,
        tipOfTheDayLoaded: tipOfTheDayLoaded ?? this.tipOfTheDayLoaded,
      );

  @override
  List<Object?> get props => [
        weatherDataStatus,
        tipOfTheDay,
        plantationGuides,
        plantationGuidesStatus,
        weatherBasedPlantSuggestions,
        weatherBasedSuggestionsStatus,
        weatherBasedSuggestions,
        weatherBasedPlantSuggestionsStatus,
        weatherData,
        currentWeatherPlantsType,
        tipOfTheDayLoaded,
      ];
}
