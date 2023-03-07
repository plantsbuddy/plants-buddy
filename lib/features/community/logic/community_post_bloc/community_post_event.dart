part of 'community_post_bloc.dart';

@immutable
abstract class CommunityPostEvent {}

class CommunityPostCommentsStreamInitialize extends CommunityPostEvent {}

class CommunityPostAddComment extends CommunityPostEvent {
  final String body;

  CommunityPostAddComment(this.body);
}
