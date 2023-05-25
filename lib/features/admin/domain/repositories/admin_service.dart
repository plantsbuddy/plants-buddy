import '../../../authentication/domain/entities/botanist.dart';
import '../entities/report.dart';

abstract class AdminService {
  Future<Stream<List<Map<String, dynamic>>>> get reportedPostsStream;

  Future<Stream<List<Map<String, dynamic>>>> get reportedCommentsStream;

  Future<Stream<List<Map<String, dynamic>>>> get reportedRatingsStream;

  Future<Stream<List<Map<String, dynamic>>>> get reportedBotanistsStream;

  Future<Stream<List<Map<String, dynamic>>>> get blockedUsersStream;

  Future<List<Report>> getReports({required String collectionName, required String docId});

  Future<void> ignoreReport({required String collectionName, required String docId});

  Future<void> removeCommunityPost(String id);

  Future<void> removePostComment({required String postId, required String commentId});

  Future<void> removeBotanistRating({required String botanistUid, required String ratingId});

  Future<void> blockUser(String uid);

  Future<void> unblockUser(String uid);
}
