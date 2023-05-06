import 'dart:developer';

import 'package:plants_buddy/features/identification/domain/entities/identification_result.dart';
import 'package:plants_buddy/features/identification/domain/repositories/identification_service.dart';
import 'package:tflite/tflite.dart';
import 'package:plants_buddy/features/identification/logic/identification_bloc/identification_bloc.dart';

class SaveIdentificationForHistory {
  final IdentificationService _identificationService;

  SaveIdentificationForHistory(this._identificationService);

  Future<void> call({
    required IdentificationType identificationType,
    required String imagePath,
    required List<IdentificationResult> results,
  }) async {
    return _identificationService.saveIdentificationForHistory(
      identificationType: identificationType,
      imagePath: imagePath,
      results: results,
    );
  }
}
