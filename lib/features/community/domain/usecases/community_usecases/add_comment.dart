import 'package:firebase_auth/firebase_auth.dart';
import 'package:plants_buddy/core/errors/exceptions.dart';
import 'package:plants_buddy/features/community/data/community_data_source.dart';
import 'package:plants_buddy/features/community/domain/repositories/community_repository.dart';

import '../../entities/comment.dart';

class AddComment {
  final CommunityRepository _communityRepository;

  AddComment(this._communityRepository);

  Future<void> call({required String postId, required String body}) async {
    if (body.trim().isEmpty) {
      return;
    }

    Comment comment = Comment(
      body: body.trim(),
      author: FirebaseAuth.instance.currentUser!.uid,
      postedAt: DateTime.now().millisecondsSinceEpoch,
    );

    await _communityRepository.addCommentToPost(postId: postId, comment: comment);
  }
}
