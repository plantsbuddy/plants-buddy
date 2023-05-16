import 'package:plants_buddy/features/admin/domain/repositories/admin_service.dart';

class GetBlockedUsersStream {
  final AdminService _adminService;

  GetBlockedUsersStream(this._adminService);

  Future<Stream<List<Map<String, dynamic>>>> call() async {
    return _adminService.blockedUsersStream;
  }
}
