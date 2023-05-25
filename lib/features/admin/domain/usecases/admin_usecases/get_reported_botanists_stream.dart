import 'package:plants_buddy/features/admin/domain/repositories/admin_service.dart';

import 'package:plants_buddy/features/authentication/domain/entities/botanist.dart';

class GetReportedBotanistsStream {
  final AdminService _adminService;

  GetReportedBotanistsStream(this._adminService);

  Future<Stream<List<Map<String, dynamic>>>> call() async {
    return _adminService.reportedBotanistsStream;
  }
}
