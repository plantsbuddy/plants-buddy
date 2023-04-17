import 'package:plants_buddy/core/errors/exceptions.dart';
import 'package:plants_buddy/features/reminders/domain/repositories/reminders_repository.dart';
import 'package:plants_buddy/features/suggestions/domain/entities/plantation_guide.dart';
import 'package:plants_buddy/features/suggestions/domain/repositories/suggestions_service.dart';

class GetPlantationGuides {
  final SuggestionsService _suggestionsService;

  GetPlantationGuides(this._suggestionsService);

  Future<List<PlantationGuide>> call() async {
    return _suggestionsService.plantationGuides;
  }
}
