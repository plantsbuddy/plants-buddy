import '../../../../authentication/domain/entities/botanist.dart';
import '../../repositories/appointment_service.dart';

class GetBotanists {
  final AppointmentService _appointmentService;

  GetBotanists(this._appointmentService);

  Future<List<Botanist>> call() async {
    return _appointmentService.getBotanists();
  }
}
