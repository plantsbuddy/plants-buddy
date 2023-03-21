abstract class IdentificationService {
  Future<Map<String, dynamic>> getPlantDetails(String name);

  Future<Map<String, dynamic>> getDiseaseDetails(String name);

  Future<Map<String, dynamic>> getPestDetails(String name);
}
