import 'package:plants_buddy/features/community/data/community_data_source.dart';

import '../../repositories/community_repository.dart';

class DeleteComment {
  final CommunityService _communityRepository;
  DeleteComment(this._communityRepository);

  Future<void> call() async {}
}
