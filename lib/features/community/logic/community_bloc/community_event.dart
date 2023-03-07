part of 'community_bloc.dart';

@immutable
abstract class CommunityEvent {}

class CommunityPostsStreamInitialize extends CommunityEvent {}

class CommunityDeletePostPressed extends CommunityEvent {
  final String id;

  CommunityDeletePostPressed(this.id);
}

class CommunityUpdatePostPressed extends CommunityEvent {}

class CommunitySearchTermUpdated extends CommunityEvent {
  final String term;

  CommunitySearchTermUpdated(this.term);
}

class CommunityMyPostsToggled extends CommunityEvent {}
