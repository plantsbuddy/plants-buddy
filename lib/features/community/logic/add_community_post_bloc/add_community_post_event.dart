part of 'add_community_post_bloc.dart';

@immutable
abstract class AddCommunityPostEvent {}

class AddCommunityPostPressed extends AddCommunityPostEvent {}

class AddCommunityPostAttachImagePressed extends AddCommunityPostEvent {}

class AddCommunityPostRemoveImagePressed extends AddCommunityPostEvent {}

class AddCommunityPostCategoryToggled extends AddCommunityPostEvent {
  final String category;

  AddCommunityPostCategoryToggled(this.category);
}

class AddCommunityPostTitleChanged extends AddCommunityPostEvent {
  final String title;

  AddCommunityPostTitleChanged(this.title);
}

class AddCommunityPostDescriptionChanged extends AddCommunityPostEvent {
  final String description;

  AddCommunityPostDescriptionChanged(this.description);
}
