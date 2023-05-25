import 'package:plants_buddy/features/admin/domain/repositories/admin_service.dart';

class IgnoreReport {
  final AdminService _adminService;

  IgnoreReport(this._adminService);

  Future<void> call({required String collectionName, required String docId}) async {
    return _adminService.ignoreReport(collectionName: collectionName, docId: docId);
  }
}
