import '../../logic/identification_bloc/identification_bloc.dart';
import '../entities/identification_history_item.dart';
import '../entities/identification_result.dart';

abstract class IdentificationService {
  Future<Map<String, dynamic>> getPlantDetails(String name);

  Future<Map<String, dynamic>> getDiseaseDetails(String name);

  Future<Map<String, dynamic>> getPestDetails(String name);

  Future<void> saveIdentificationForHistory({
    required IdentificationType identificationType,
    required String imagePath,
    required List<IdentificationResult> results,
  });

  Future<List<IdentificationHistoryItem>> getIdentificationHistory(IdentificationType identificationType);
}
