import 'package:plants_buddy/features/admin/domain/repositories/admin_service.dart';

import '../../entities/report.dart';

class GetReports {
  final AdminService _adminService;

  GetReports(this._adminService);

  Future<List<Report>> call({required String collectionName, required String docId}) async {
    return _adminService.getReports(collectionName: collectionName, docId: docId);
  }
}
