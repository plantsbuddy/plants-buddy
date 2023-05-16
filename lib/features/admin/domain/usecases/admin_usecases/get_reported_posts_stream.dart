import 'package:plants_buddy/features/admin/domain/repositories/admin_service.dart';

class GetReportedPostsStream {
  final AdminService _adminService;

  GetReportedPostsStream(this._adminService);

  Future<Stream<List<Map<String, dynamic>>>> call() async {
    return _adminService.reportedPostsStream;
  }
}
