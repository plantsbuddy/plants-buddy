import 'package:firebase_auth/firebase_auth.dart';
import 'package:plants_buddy/core/errors/exceptions.dart';
import 'package:plants_buddy/features/community/data/community_data_source.dart';
import 'package:plants_buddy/features/community/domain/entities/community_post.dart';

import '../../repositories/community_repository.dart';

class AddCommunityPost {
  final CommunityService _communityRepository;

  AddCommunityPost(this._communityRepository);

  Future<void> call({
    required String title,
    required String description,
    String? category,
    String? imagePath,
  }) async {
    if (title.trim().isEmpty) {
      throw EmptyPostTitleException();
    }

    if (description.trim().isEmpty) {
      throw EmptyPostDescriptionException();
    }



    // CommunityPost post = CommunityPost(
    //   author: FirebaseAuth.instance.currentUser!.uid,
    //   title: title.trim(),
    //   category: category,
    //   description: description.trim(),
    //   imageUrl: image,
    //   postedAt: DateTime.now().millisecondsSinceEpoch,
    // );

    await _communityRepository.addCommunityPost(
      title: title.trim(),
      description: description.trim(),
      category: category,
      imagePath: imagePath,
    );
  }
}
