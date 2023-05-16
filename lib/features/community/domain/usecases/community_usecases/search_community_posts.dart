import 'package:plants_buddy/core/errors/exceptions.dart';

import '../../entities/community_post.dart';
import '../../repositories/community_repository.dart';

class SearchCommunityPosts {
  final CommunityService _communityRepository;

  SearchCommunityPosts(this._communityRepository);

  Future<List<CommunityPost>> call(String searchTerm) async {
    if (searchTerm.trim().isEmpty) {
      throw EmptyCommunitySearchTermException();
    }

    return await _communityRepository.searchCommunityPosts(searchTerm.trim().toLowerCase());
  }
}
