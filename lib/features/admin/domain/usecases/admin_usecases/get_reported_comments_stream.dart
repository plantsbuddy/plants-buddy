import 'package:plants_buddy/features/admin/domain/repositories/admin_service.dart';

class GetReportedCommentsStream {
  final AdminService _adminService;

  GetReportedCommentsStream(this._adminService);

  Future<Stream<List<Map<String, dynamic>>>> call() async {
    return _adminService.reportedCommentsStream;
  }
}
