import 'package:plants_buddy/features/community/data/community_data_source.dart';
import 'package:plants_buddy/features/community/domain/entities/community_post.dart';

import '../../repositories/community_repository.dart';

class GetMyCommunityPosts {
  final CommunityService _communityRepository;
  GetMyCommunityPosts(this._communityRepository);

  Future<List<CommunityPost>> call() async {
    return await _communityRepository.getMyCommunityPosts();
  }
}