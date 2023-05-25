import '../entities/comment.dart';
import '../entities/community_post.dart';

abstract class CommunityService {
  Future<Stream<List<CommunityPost>>> getCommunityPostsStream({required bool myPostsOnly});

  Future<void> addCommunityPost({
    required String title,
    required String description,
    String? category,
    String? imagePath,
  });

  Future<List<CommunityPost>> searchCommunityPosts(String searchTerm);

  Future<void> addCommentToPost({required String postId, required Comment comment});

  Future<Stream<List<Comment>>> getPostCommentsStream(String postId);

  Future<void> deleteCommunityPost(String postId);

  Future<void> updateCommunityPost({
    required String postId,
    required String title,
    required String description,
    String? category,
    String? imagePath,
  });

  Future<void> reportComment({required CommunityPost post, required Comment comment, required String reportText});

  Future<void> reportCommunityPost({required CommunityPost post, required String reportText});
}
