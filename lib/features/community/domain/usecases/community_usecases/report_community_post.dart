import 'package:firebase_auth/firebase_auth.dart';
import 'package:plants_buddy/core/errors/exceptions.dart';
import 'package:plants_buddy/features/community/data/community_data_source.dart';
import 'package:plants_buddy/features/community/domain/entities/community_post.dart';
import 'package:plants_buddy/features/community/domain/repositories/community_repository.dart';

import '../../entities/comment.dart';

class ReportCommunityPost {
  final CommunityService _communityRepository;

  ReportCommunityPost(this._communityRepository);

  Future<void> call({required CommunityPost post, required String reportText}) async {
    return _communityRepository.reportCommunityPost(post: post, reportText: reportText);
  }
}
