import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plants_buddy/features/admin/domain/repositories/admin_service.dart';

class AdminServiceImpl implements AdminService {
  final FirebaseFirestore firestore;

  final _postsStreamController = StreamController<List<Map<String, dynamic>>>.broadcast();
  final _commentsStreamController = StreamController<List<Map<String, dynamic>>>.broadcast();
  final _ratingsStreamController = StreamController<List<Map<String, dynamic>>>.broadcast();
  final _usersStreamController = StreamController<List<Map<String, dynamic>>>.broadcast();

  AdminServiceImpl() : firestore = FirebaseFirestore.instance;

  @override
  Future<Stream<List<Map<String, dynamic>>>> get reportedPostsStream async {
    firestore.collection('reported_community_posts').snapshots().listen((postsSnapshots) {
      List<Map<String, dynamic>> reportedPosts = [];

      for (var reportedPostDocument in postsSnapshots.docs) {
        reportedPosts.add(reportedPostDocument.data());
      }

      _postsStreamController.add(reportedPosts);
    });

    return _postsStreamController.stream.asBroadcastStream();
  }

  @override
  Future<Stream<List<Map<String, dynamic>>>> get reportedCommentsStream async {
    firestore.collection('reported_community_comments').snapshots().listen((commentsSnapshots) {
      List<Map<String, dynamic>> reportedComments = [];

      for (var reportedCommentDocument in commentsSnapshots.docs) {
        reportedComments.add(reportedCommentDocument.data());
      }

      _commentsStreamController.add(reportedComments);
    });

    return _commentsStreamController.stream.asBroadcastStream();
  }

  @override
  Future<Stream<List<Map<String, dynamic>>>> get reportedRatingsStream async {
    firestore.collection('reported_botanist_ratings').snapshots().listen((ratingsSnapshots) {
      List<Map<String, dynamic>> reportedRatings = [];

      for (var reportedRatingDocument in ratingsSnapshots.docs) {
        reportedRatings.add(reportedRatingDocument.data());
      }

      _ratingsStreamController.add(reportedRatings);
    });

    return _ratingsStreamController.stream.asBroadcastStream();
  }

  @override
  Future<Stream<List<Map<String, dynamic>>>> get blockedUsersStream async {
    firestore.collection('users').where('blocked', isEqualTo: true).snapshots().listen((usersSnapshots) {
      List<Map<String, dynamic>> blockedUsers = [];

      for (var blockedUserDocument in usersSnapshots.docs) {
        blockedUsers.add(blockedUserDocument.data());
      }

      _usersStreamController.add(blockedUsers);
    });

    return _usersStreamController.stream.asBroadcastStream();
  }

  @override
  Future<void> removeCommunityPost(String id) async {
    await firestore.collection('reported_community_posts').doc(id).delete();

    await firestore.collection('community_posts').doc(id).delete();
  }

  @override
  Future<void> removePostComment({required String postId, required String commentId}) async {
    await firestore.collection('reported_community_comments').doc(commentId).delete();

    await firestore.collection('community_posts').doc(postId).collection('comments').doc(commentId).delete();
  }

  @override
  Future<void> removeBotanistRating({required String botanistUid, required String ratingId}) async {
    await firestore.collection('reported_botanist_reviews').doc(ratingId).delete();

    await firestore.collection('users').doc(botanistUid).collection('reviews').doc(ratingId).delete();
  }

  @override
  Future<void> blockUser(String uid) async {
    await firestore.collection('users').doc(uid).update({'blocked': true});
  }

  @override
  Future<void> unblockUser(String uid) async {
    await firestore.collection('users').doc(uid).update({'blocked': false});
  }
}
