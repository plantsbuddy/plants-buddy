import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plants_buddy/features/community/domain/entities/community_post.dart';
import 'package:plants_buddy/features/community/domain/repositories/community_repository.dart';
import '../domain/entities/comment.dart';
import '../domain/entities/user.dart';

class CommunityDataSource implements CommunityRepository {
  final CollectionReference _postsCollection;
  final CollectionReference _usersCollection;
  final StreamController<List<CommunityPost>> _postsController;

  CommunityDataSource()
      : _postsCollection = FirebaseFirestore.instance.collection('community_posts'),
        _usersCollection = FirebaseFirestore.instance.collection('users'),
        _postsController = StreamController<List<CommunityPost>>.broadcast();

  @override
  Future<Stream<List<CommunityPost>>> getCommunityPostsStream() async {
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
  Future<List<CommunityPost>> getMyCommunityPosts() async {
    final myPostsDocuments = await _postsCollection
        .where(
          'author',
          isEqualTo: FirebaseAuth.instance.currentUser!.uid,
        )
        .get();
    List<CommunityPost> myPosts = [];

    for (var postDocument in myPostsDocuments.docs) {
      myPosts.add(await _createPostFromDocument(postDocument));
    }

    return myPosts;
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
          pictureUrl: userDetailsRef.get('pictureUrl'),
        );

        Comment comment = Comment(
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
    final imageUrl = postDocument.get('imageUrl') as String?;
    final postedAt = postDocument.get('postedAt') as int;

    final postDetailsRef = await _usersCollection.doc(authorUid).get();

    User author = User(
      uid: authorUid,
      name: postDetailsRef.get('name') as String,
      pictureUrl: postDetailsRef.get('pictureUrl') as String,
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
    }
  }

  @override
  Future<void> deleteCommunityPost(String postId) async {
    await _postsCollection.doc(postId).delete();
  }

  @override
  Future<void> updateCommunityPost(
      {required String postId,
      required String title,
      required String description,
      String? category,
      String? imagePath}) async {
    final postRef = _postsCollection.doc(postId);
    await postRef.update({
      'title': title,
      'category': category,
      'description': description,
    });
    await _uploadImage(postRef: postRef, imagePath: imagePath);
  }
}
