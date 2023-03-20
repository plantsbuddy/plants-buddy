import 'package:plants_buddy/features/identification/domain/entities/identification_result.dart';
import 'package:tflite/tflite.dart';
import 'package:plants_buddy/features/identification/logic/identification_bloc.dart';

class PerformIdentification {
  Future<List<IdentificationResult>?> call(
      {required IdentificationType identificationType, required String imagePath}) async {
    Tflite.close();

    switch (identificationType) {
      case IdentificationType.plant:
        await Tflite.loadModel(model: "assets/models/plant_model.tflite", labels: "assets/models/plant_labels.txt");
        break;
      case IdentificationType.disease:
        await Tflite.loadModel(model: "assets/models/disease_model.tflite", labels: "assets/models/disease_labels.txt");
        break;
      case IdentificationType.pest:
        await Tflite.loadModel(model: "assets/models/pest_model.tflite", labels: "assets/models/pest_labels.txt");
        break;
    }

    final List? predictions = await Tflite.runModelOnImage(
      path: imagePath,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    return predictions
        ?.map((prediction) =>
            IdentificationResult(confidence: prediction['confidence'] as double, label: prediction['label'] as String))
        .toList();
  }
}
