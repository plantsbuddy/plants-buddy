import 'package:plants_buddy/features/admin/domain/repositories/admin_service.dart';

class UnblockUser {
  final AdminService _adminService;

  UnblockUser(this._adminService);

  Future<void> call(String uid) async {
    return _adminService.unblockUser(uid);
  }
}
