import 'package:plants_buddy/features/admin/domain/repositories/admin_service.dart';

class GetReportedRatingsStream {
  final AdminService _adminService;

  GetReportedRatingsStream(this._adminService);

  Future<Stream<List<Map<String, dynamic>>>> call() async {
    return _adminService.reportedRatingsStream;
  }
}
