import 'package:plants_buddy/features/admin/domain/repositories/admin_service.dart';

class DeleteReportedComment {
  final AdminService _adminService;

  DeleteReportedComment(this._adminService);

  Future<void> call({required String commentId, required String postId}) async {
    return _adminService.removePostComment(postId: postId, commentId: commentId);
  }
}
