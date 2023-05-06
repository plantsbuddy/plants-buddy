import 'package:plants_buddy/core/errors/exceptions.dart';
import 'package:plants_buddy/features/reminders/domain/repositories/reminders_repository.dart';
import 'package:plants_buddy/features/suggestions/domain/entities/plantation_guide.dart';
import 'package:plants_buddy/features/suggestions/domain/repositories/suggestions_service.dart';

class GetWeatherData {
  final SuggestionsService _suggestionsService;

  GetWeatherData(this._suggestionsService);

  Future<Map<String, dynamic>> call() async {
    return _suggestionsService.weatherData;
  }
}
