abstract class AdminService {
  Future<Stream<List<Map<String, dynamic>>>> get reportedPostsStream;

  Future<Stream<List<Map<String, dynamic>>>> get reportedCommentsStream;

  Future<Stream<List<Map<String, dynamic>>>> get reportedRatingsStream;

  Future<Stream<List<Map<String, dynamic>>>> get blockedUsersStream;

  Future<void> removeCommunityPost(String id);

  Future<void> removePostComment({required String postId, required String commentId});

  Future<void> removeBotanistRating({required String botanistUid, required String ratingId});

  Future<void> blockUser(String uid);

  Future<void> unblockUser(String uid);
}
