part of 'community_post_bloc.dart';

@immutable
abstract class CommunityPostEvent {}

class CommunityPostCommentsStreamInitialize extends CommunityPostEvent {}

class CommunityPostAddComment extends CommunityPostEvent {
  final String body;

  CommunityPostAddComment(this.body);
}

class CommunityPostReportPost extends CommunityPostEvent {
  final String reportText;
  final CommunityPost post;

  CommunityPostReportPost({required this.reportText, required this.post});
}

class CommunityPostReportComment extends CommunityPostEvent {
  final String reportText;
  final CommunityPost post;
  final Comment comment;

  CommunityPostReportComment({required this.reportText, required this.post, required this.comment});
}
