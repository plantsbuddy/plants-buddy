part of 'community_post_bloc.dart';

enum CommunityPostCommentsStatus { loading, loaded }

@immutable
class CommunityPostState extends Equatable {
  final List<Comment> comments;
  final String? commentError;
  final String postId;
  final CommunityPostCommentsStatus status;

  CommunityPostState.initial(this.postId)
      : comments = [],
        commentError = null,
        status = CommunityPostCommentsStatus.loading;

  const CommunityPostState({
    required this.comments,
    required this.commentError,
    required this.postId,
    required this.status,
  });

  CommunityPostState copyWith({
    List<Comment>? comments,
    String? Function()? commentError,
    String? postId,
    CommunityPostCommentsStatus? status,
  }) =>
      CommunityPostState(
        comments: comments ?? this.comments,
        commentError: commentError == null ? this.commentError : commentError(),
        postId: postId ?? this.postId,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [status, postId, comments, commentError];
}
