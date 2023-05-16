import 'package:plants_buddy/features/admin/domain/repositories/admin_service.dart';

class DeleteReportedBotanistRating {
  final AdminService _adminService;

  DeleteReportedBotanistRating(this._adminService);

  Future<void> call({required String ratingId, required String botanistId}) async {
    return _adminService.removeBotanistRating(ratingId: ratingId, botanistUid: botanistId);
  }
}
