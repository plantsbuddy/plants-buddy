import 'package:plants_buddy/features/community/data/community_data_source.dart';
import 'package:plants_buddy/features/community/domain/entities/community_post.dart';

import '../../repositories/community_repository.dart';

class GetCommunityPostsStream {
  final CommunityRepository _communityRepository;
  GetCommunityPostsStream(this._communityRepository);

  Future<Stream<List<CommunityPost>>> call() async {
    return await _communityRepository.getCommunityPostsStream();
  }
}