import 'package:plants_buddy/features/admin/domain/repositories/admin_service.dart';

class BlockUser {
  final AdminService _adminService;

  BlockUser(this._adminService);

  Future<void> call(String uid) async {
    return _adminService.blockUser(uid);
  }
}
