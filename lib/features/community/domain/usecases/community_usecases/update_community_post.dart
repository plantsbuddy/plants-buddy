import 'package:plants_buddy/core/errors/exceptions.dart';

import '../../repositories/community_repository.dart';

class UpdateCommunityPost {
  final CommunityService _communityRepository;

  UpdateCommunityPost(this._communityRepository);

  Future<void> call({
    required String postId,
    required String title,
    required String description,
    String? category,
    String? imagePath,
    required bool imageAttached,
  }) async {
    if (title.trim().isEmpty) {
      throw EmptyPostTitleException();
    }

    if (description.trim().isEmpty) {
      throw EmptyPostDescriptionException();
    }

    await _communityRepository.updateCommunityPost(
      postId: postId,
      title: title.trim(),
      description: description.trim(),
      category: category,
      imagePath: imageAttached ? imagePath : null,
    );
  }
}
