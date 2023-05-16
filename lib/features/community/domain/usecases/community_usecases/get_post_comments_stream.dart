import 'package:plants_buddy/features/community/data/community_data_source.dart';
import 'package:plants_buddy/features/community/domain/entities/comment.dart';
import 'package:plants_buddy/features/community/domain/entities/community_post.dart';

import '../../repositories/community_repository.dart';

class GetPostCommentsStream {
  final CommunityService _communityRepository;
  GetPostCommentsStream(this._communityRepository);

  Future<Stream<List<Comment>>> call(String postId) async {
    return await _communityRepository.getPostCommentsStream(postId);
  }
}
