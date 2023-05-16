import 'package:plants_buddy/features/admin/domain/repositories/admin_service.dart';

class DeleteReportedPost {
  final AdminService _adminService;

  DeleteReportedPost(this._adminService);

  Future<void> call(String id) async {
    return _adminService.removeCommunityPost(id);
  }
}
