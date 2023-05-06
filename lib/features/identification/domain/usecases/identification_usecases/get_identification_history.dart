import 'package:image_picker/image_picker.dart';
import 'package:plants_buddy/features/identification/domain/entities/identification_history_item.dart';
import 'package:plants_buddy/features/identification/logic/identification_bloc/identification_bloc.dart';

import '../../repositories/identification_service.dart';

class GetIdentificationHistory {
  final IdentificationService _identificationService;

  GetIdentificationHistory(this._identificationService);

  Future<List<IdentificationHistoryItem>> call(IdentificationType identificationType) async {
    return _identificationService.getIdentificationHistory(identificationType);
  }
}
