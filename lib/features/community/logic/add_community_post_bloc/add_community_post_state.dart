part of 'add_community_post_bloc.dart';

@immutable
class AddCommunityPostState extends Equatable {
  final String title;
  final String description;
  final String? titleError;
  final String? descriptionError;
  final String? image;
  final bool imageAttached;
  final String? category;
  final bool dialogShowing;
  final CommunityPost? originalPost;

  AddCommunityPostState.create()
      : title = '',
        description = '',
        titleError = null,
        descriptionError = null,
        image = null,
        originalPost = null,
        dialogShowing = false,
        imageAttached = false,
        category = null;

  AddCommunityPostState.update(CommunityPost this.originalPost)
      : title = originalPost.title,
        description = originalPost.description,
        titleError = null,
        descriptionError = null,
        image = null,
        imageAttached = originalPost.imageUrl != null,
        dialogShowing = false,
        category = originalPost.category;

  const AddCommunityPostState({
    required this.title,
    required this.description,
    required this.dialogShowing,
    required this.imageAttached,
    this.titleError,
    this.descriptionError,
    this.category,
    this.image,
    this.originalPost,
  });

  AddCommunityPostState copyWith({
    String? title,
    String? description,
    String? Function()? titleError,
    String? Function()? descriptionError,
    String? Function()? category,
    String? Function()? image,
    bool? dialogShowing,
    bool? imageAttached,
  }) =>
      AddCommunityPostState(
        title: title ?? this.title,
        description: description ?? this.description,
        titleError: titleError == null ? this.titleError : titleError(),
        category: category == null ? this.category : category(),
        descriptionError: descriptionError == null ? this.descriptionError : descriptionError(),
        image: image == null ? this.image : image(),
        originalPost: originalPost,
        dialogShowing: dialogShowing ?? this.dialogShowing,
        imageAttached: imageAttached ?? this.imageAttached,
      );

  @override
  List<Object?> get props => [
        title,
        description,
        titleError,
        descriptionError,
        category,
        image,
        dialogShowing,
        imageAttached,
      ];
}
