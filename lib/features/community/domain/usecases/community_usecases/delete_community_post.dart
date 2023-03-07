import 'package:plants_buddy/features/community/data/community_data_source.dart';

import '../../repositories/community_repository.dart';

class DeleteCommunityPost {
  final CommunityRepository _communityRepository;

  DeleteCommunityPost(this._communityRepository);

  Future<void> call(String postId) async {
    await _communityRepository.deleteCommunityPost(postId);
  }
}
