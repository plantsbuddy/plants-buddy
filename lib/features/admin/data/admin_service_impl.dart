import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plants_buddy/features/admin/domain/repositories/admin_service.dart';

import '../../authentication/domain/entities/botanist.dart';
import '../domain/entities/report.dart';

class AdminServiceImpl implements AdminService {
  final FirebaseFirestore firestore;

  final _postsStreamController = StreamController<List<Map<String, dynamic>>>.broadcast();
  final _commentsStreamController = StreamController<List<Map<String, dynamic>>>.broadcast();
  final _ratingsStreamController = StreamController<List<Map<String, dynamic>>>.broadcast();
  final _botanistsStreamController = StreamController<List<Map<String, dynamic>>>.broadcast();
  final _blockedUsersStreamController = StreamController<List<Map<String, dynamic>>>.broadcast();

  AdminServiceImpl() : firestore = FirebaseFirestore.instance;

  @override
  Future<Stream<List<Map<String, dynamic>>>> get reportedPostsStream async {
    firestore.collection('reported_community_posts').snapshots().listen((postsSnapshots) async {
      List<Map<String, dynamic>> reportedPosts = [];

      for (var reportedPostDocument in postsSnapshots.docs) {
        final Map<String, dynamic> reportedPost = {'id': reportedPostDocument.id};

        reportedPost['post'] = await getCommunityPost(reportedPostDocument.id);
        reportedPost['author'] = await getUserDetails(reportedPost['post']['author']);

        reportedPosts.add(reportedPost);
      }

      _postsStreamController.add(reportedPosts);
    });

    return _postsStreamController.stream.asBroadcastStream();
  }

  @override
  Future<Stream<List<Map<String, dynamic>>>> get reportedCommentsStream async {
    firestore.collection('reported_community_comments').snapshots().listen((commentsSnapshots) async {
      List<Map<String, dynamic>> reportedComments = [];

      for (var reportedCommentDocument in commentsSnapshots.docs) {
        final Map<String, dynamic> reportedComment = {'id': reportedCommentDocument.id};

        final commentDoc = await firestore
            .collection('community_posts')
            .doc(reportedCommentDocument.get('post_id'))
            .collection('comments')
            .doc(reportedCommentDocument.get('comment_id'))
            .get();

        reportedComment['comment'] = commentDoc.data();
        reportedComment['author'] = await getUserDetails(commentDoc.get('author'));
        reportedComment['post_id'] = reportedCommentDocument.get('post_id');
        reportedComment['comment_id'] = reportedCommentDocument.get('comment_id');

        reportedComments.add(reportedComment);
      }

      _commentsStreamController.add(reportedComments);
    });

    return _commentsStreamController.stream.asBroadcastStream();
  }

  @override
  Future<Stream<List<Map<String, dynamic>>>> get reportedRatingsStream async {
    firestore.collection('reported_botanist_reviews').snapshots().listen((ratingsSnapshots) async {
      List<Map<String, dynamic>> reportedRatings = [];

      for (var reportedRatingDocument in ratingsSnapshots.docs) {
        final Map<String, dynamic> reportedRating = {'id': reportedRatingDocument.id};

        final ratingDoc = await firestore
            .collection('users')
            .doc(reportedRatingDocument.get('botanist_id'))
            .collection('reviews')
            .doc(reportedRatingDocument.get('reviewer_id'))
            .get();

        reportedRating['rating'] = ratingDoc.data();
        reportedRating['author'] = await getUserDetails(ratingDoc.get('author'));
        reportedRating['botanist_id'] = reportedRatingDocument.get('botanist_id');
        reportedRating['reviewer_id'] = reportedRatingDocument.get('reviewer_id');

        reportedRatings.add(reportedRating);
      }

      _ratingsStreamController.add(reportedRatings);
    });

    return _ratingsStreamController.stream.asBroadcastStream();
  }

  @override
  Future<Stream<List<Map<String, dynamic>>>> get reportedBotanistsStream async {
    firestore.collection('reported_botanists').snapshots().listen((botanistsSnapshots) async {
      List<Map<String, dynamic>> reportedBotanists = [];

      for (var reportedBotanistDocument in botanistsSnapshots.docs) {
        final reportedBotanist = {
          'id': reportedBotanistDocument.id,
          'botanist': await getBotanist(reportedBotanistDocument.id),
        };

        reportedBotanists.add(reportedBotanist);
      }

      _botanistsStreamController.add(reportedBotanists);
    });

    return _botanistsStreamController.stream.asBroadcastStream();
  }

  @override
  Future<Stream<List<Map<String, dynamic>>>> get blockedUsersStream async {
    firestore.collection('users').where('blocked', isEqualTo: true).snapshots().listen((usersSnapshots) async {
      List<Map<String, dynamic>> blockedUsers = [];

      for (var blockedUserDocument in usersSnapshots.docs) {
        blockedUsers.add(await getUserDetails(blockedUserDocument.id));
      }

      _blockedUsersStreamController.add(blockedUsers);
    });

    return _blockedUsersStreamController.stream.asBroadcastStream();
  }

  @override
  Future<List<Report>> getReports({required String collectionName, required String docId}) async {
    final reportersSnapshots = await firestore.collection(collectionName).doc(docId).collection('reporters').get();

    final List<Report> reporters = [];

    for (var reporterDoc in reportersSnapshots.docs) {
      final author = await getUserDetails(reporterDoc.id);

      final report = Report(
        authorName: author['name'] as String,
        authorEmail: author['email'] as String,
        authorPicUrl: author['pictureUrl'] as String,
        body: reporterDoc.get('report_text'),
        time: reporterDoc.get('time'),
      );

      reporters.add(report);
    }

    return reporters;
  }

  @override
  Future<void> removeCommunityPost(String id) async {
    await firestore.collection('reported_community_posts').doc(id).delete();

    await firestore.collection('community_posts').doc(id).delete();
  }

  @override
  Future<void> removePostComment({required String postId, required String commentId}) async {
    final Query query = firestore
        .collection('reported_community_comments')
        .where('comment_id', isEqualTo: commentId)
        .where('post_id', isEqualTo: postId);

    final QuerySnapshot snapshot = await query.get();

    final WriteBatch batch = FirebaseFirestore.instance.batch();

    for (final DocumentSnapshot docSnapshot in snapshot.docs) {
      batch.delete(docSnapshot.reference);
    }
    await batch.commit();

    await firestore.collection('community_posts').doc(postId).collection('comments').doc(commentId).delete();
  }

  @override
  Future<void> removeBotanistRating({required String botanistUid, required String ratingId}) async {
    final Query query = firestore
        .collection('reported_botanist_reviews')
        .where('reviewer_id', isEqualTo: ratingId)
        .where('botanist_id', isEqualTo: botanistUid);

    final QuerySnapshot snapshot = await query.get();

    final WriteBatch batch = FirebaseFirestore.instance.batch();

    for (final DocumentSnapshot docSnapshot in snapshot.docs) {
      batch.delete(docSnapshot.reference);
    }
    await batch.commit();

    await firestore.collection('users').doc(botanistUid).collection('reviews').doc(ratingId).delete();
  }

  @override
  Future<void> ignoreReport({required String collectionName, required String docId}) async {
    await firestore.collection(collectionName).doc(docId).delete();
    // await firestore.collection(collectionName).doc(docId).collection('reporters').doc(reportId).delete();
  }

  @override
  Future<void> blockUser(String uid) async {
    await firestore.collection('users').doc(uid).update({'blocked': true});

    await firestore.collection('reported_botanists').doc(uid).delete();
  }

  @override
  Future<void> unblockUser(String uid) async {
    await firestore.collection('users').doc(uid).update({'blocked': false});
  }

  Future<Map<String, String>> getUserDetails(String uid) async {
    final details = await firestore.collection('users').doc(uid).get();

    return {
      'uid': details.id,
      'name': details.get('name'),
      'email': details.get('email'),
      'pictureUrl': details.get('pictureUrl'),
      'user_type': details.get('type'),
    };
  }

  Future<Map<String, dynamic>> getCommunityPost(String id) async {
    final details = await firestore.collection('community_posts').doc(id).get();

    final post = {
      'author': details.get('author'),
      'title': details.get('title'),
      'description': details.get('description'),
    };

    try {
      post['imageUrl'] = details.get(('imageUrl'));
    } on StateError {
      post['imageUrl'] = null;
    }

    return post;
  }

  Future<Botanist> getBotanist(String uid) async {
    final botanistMap = await firestore.collection('users').doc(uid).get();

    final botanist = Botanist(
      uid: botanistMap.id,
      username: botanistMap.get('name'),
      email: botanistMap.get('email'),
      profilePicture: botanistMap.get('pictureUrl'),
      consultationCharges: botanistMap.get('consultation_charges'),
      specialty: botanistMap.get('specialty'),
      description: botanistMap.get('description'),
      qualification: botanistMap.get('qualification'),
      phoneNumber: botanistMap.get('phone_number'),
      city: botanistMap.get('city'),
    );

    return botanist;
  }
}
