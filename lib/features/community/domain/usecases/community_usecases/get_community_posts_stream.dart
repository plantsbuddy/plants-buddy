import 'package:plants_buddy/features/community/data/community_data_source.dart';
import 'package:plants_buddy/features/community/domain/entities/community_post.dart';

import '../../repositories/community_repository.dart';

class GetCommunityPostsStream {
  final CommunityService _communityRepository;

  GetCommunityPostsStream(this._communityRepository);

  Future<Stream<List<CommunityPost>>> call({required bool myPostsOnly}) async {
    return await _communityRepository.getCommunityPostsStream(myPostsOnly: myPostsOnly);
  }
}
