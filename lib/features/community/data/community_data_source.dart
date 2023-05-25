import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plants_buddy/features/community/domain/entities/community_post.dart';
import 'package:plants_buddy/features/community/domain/repositories/community_repository.dart';
import '../domain/entities/comment.dart';
import '../domain/entities/user.dart';

class CommunityDataSource implements CommunityService {
  final CollectionReference _postsCollection;
  final CollectionReference _usersCollection;
  final StreamController<List<CommunityPost>> _postsController;

  CommunityDataSource()
      : _postsCollection = FirebaseFirestore.instance.collection('community_posts'),
        _usersCollection = FirebaseFirestore.instance.collection('users'),
        _postsController = StreamController<List<CommunityPost>>.broadcast();

  @override
  Future<Stream<List<CommunityPost>>> getCommunityPostsStream({required bool myPostsOnly}) async {
    _postsCollection.orderBy('postedAt', descending: false).snapshots().listen(
      (documents) async {
        List<CommunityPost> posts = [];

        for (var postDocument in documents.docs) {
          posts.add(await _createPostFromDocument(postDocument));
        }

        _postsController.add(posts);
      },
    );

    return _postsController.stream.asBroadcastStream();
  }

  @override
  Future<void> addCommunityPost({
    required String title,
    required String description,
    String? category,
    String? imagePath,
  }) async {
    DocumentReference postRef = await _postsCollection.add({
      'author': FirebaseAuth.instance.currentUser!.uid,
      'title': title,
      'category': category,
      'description': description,
      'postedAt': DateTime.now().millisecondsSinceEpoch,
    });

    await _uploadImage(postRef: postRef, imagePath: imagePath);
  }

  @override
  Future<List<CommunityPost>> searchCommunityPosts(String searchTerm) async {
    final postDocuments = await _postsCollection.get();
    List<CommunityPost> matchingPosts = [];

    for (var postDocument in postDocuments.docs) {
      String title = postDocument.get('title') as String;
      String description = postDocument.get('description') as String;

      if (title.toLowerCase().contains(searchTerm) || description.toLowerCase().contains(searchTerm)) {
        matchingPosts.add(await _createPostFromDocument(postDocument));
      }
    }

    return matchingPosts;
  }

  @override
  Future<void> addCommentToPost({required String postId, required Comment comment}) async {
    await _postsCollection.doc(postId).collection('comments').add({
      'author': FirebaseAuth.instance.currentUser!.uid,
      'body': comment.body,
      'postedAt': comment.postedAt,
    });
  }

  @override
  Future<Stream<List<Comment>>> getPostCommentsStream(String postId) async {
    StreamController<List<Comment>> controller = StreamController<List<Comment>>.broadcast();
    _postsCollection.doc(postId).collection('comments').snapshots().listen((documents) async {
      List<Comment> comments = [];

      for (var document in documents.docs) {
        final authorUid = document.get('author') as String;
        final body = document.get('body') as String;
        final postedAt = document.get('postedAt') as int;

        final userDetailsRef = await _usersCollection.doc(authorUid).get();

        User author = User(
          uid: authorUid,
          name: userDetailsRef.get('name') as String,
          pictureUrl: userDetailsRef.get('pictureUrl') as String,
        );

        Comment comment = Comment(
          id: document.id,
          author: author,
          body: body,
          postedAt: postedAt,
        );

        comments.add(comment);
      }

      controller.add(comments);
    });

    return controller.stream.asBroadcastStream();
  }

  Future<CommunityPost> _createPostFromDocument(QueryDocumentSnapshot<Object?> postDocument) async {
    final authorUid = postDocument.get('author') as String;
    final title = postDocument.get('title') as String;
    final category = postDocument.get('category') as String?;
    final description = postDocument.get('description') as String;
    final imageUrl = (postDocument.data() as Map<String, dynamic>).containsKey('imageUrl')
        ? postDocument.get('imageUrl') as String?
        : null;
    final postedAt = postDocument.get('postedAt') as int;

    final postAuthorDetailsRef = await _usersCollection.doc(authorUid).get();

    User author = User(
      uid: authorUid,
      name: postAuthorDetailsRef.get('name') as String,
      pictureUrl: postAuthorDetailsRef.get('pictureUrl') as String,
    );

    final comments = await _postsCollection.doc(postDocument.id).collection('comments').get();

    return CommunityPost(
      id: postDocument.id,
      author: author,
      title: title,
      category: category,
      description: description,
      imageUrl: imageUrl,
      postedAt: postedAt,
      commentsCount: comments.docs.length,
    );
  }

  Future<void> _uploadImage({required DocumentReference postRef, required String? imagePath}) async {
    if (imagePath != null) {
      final storageRef = FirebaseStorage.instance.ref();

      final imageRef = storageRef.child('community_posts').child(postRef.id);

      await imageRef.putFile(File(imagePath));
      final imageUrl = await imageRef.getDownloadURL();

      await postRef.update({'imageUrl': imageUrl});
    } else {
      await postRef.update({'imageUrl': FieldValue.delete()});
    }
  }

  @override
  Future<void> deleteCommunityPost(String postId) async {
    await _postsCollection.doc(postId).delete();

    await FirebaseFirestore.instance.collection('reported_community_posts').doc(postId).delete();
  }

  @override
  Future<void> updateCommunityPost({
    required String postId,
    required String title,
    required String description,
    String? category,
    String? imagePath,
  }) async {
    final postRef = _postsCollection.doc(postId);
    await postRef.update({
      'title': title,
      'category': category,
      'description': description,
    });

    await _uploadImage(postRef: postRef, imagePath: imagePath);
  }

  @override
  Future<void> reportComment(
      {required CommunityPost post, required Comment comment, required String reportText}) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    final reportedCommentsCollection = FirebaseFirestore.instance.collection('reported_community_comments');

    final reportedCommentDoc = await reportedCommentsCollection.doc(comment.id).get();

    if (!reportedCommentDoc.exists) {
      reportedCommentsCollection.add({
        'post_id': post.id,
        'comment_id': comment.id,
      });
    }

    final commentReportDoc = await reportedCommentsCollection
        .where('comment_id', isEqualTo: comment.id)
        .where('post_id', isEqualTo: post.id)
        .get();

    // If user has already reported, then only the report_text will be changed
    reportedCommentsCollection.doc(commentReportDoc.docs.first.id).collection('reporters').doc(currentUserId).set({
      'report_text': reportText,
      'time': DateTime.now().millisecondsSinceEpoch,
    });
  }

  @override
  Future<void> reportCommunityPost({required CommunityPost post, required String reportText}) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    final reportedPostsCollection = FirebaseFirestore.instance.collection('reported_community_posts');

    reportedPostsCollection.doc(post.id).set({'id': post.id});

    // If user has already reported, then only the report_text will be changed
    reportedPostsCollection.doc(post.id).collection('reporters').doc(currentUserId).set({
      'report_text': reportText,
      'time': DateTime.now().millisecondsSinceEpoch,
    });
  }
}
