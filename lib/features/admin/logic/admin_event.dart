part of 'admin_bloc.dart';

@immutable
abstract class AdminEvent {}

class AdminInitializeReportedPostsStream extends AdminEvent {}

class AdminInitializeReportedBotanistsStream extends AdminEvent {}

class AdminInitializeReportedCommentsStream extends AdminEvent {}

class AdminInitializeReportedRatingsStream extends AdminEvent {}

class AdminInitializeBlockedUsersStream extends AdminEvent {}

class AdminDeletePost extends AdminEvent {
  final String id;

  AdminDeletePost(this.id);
}

class AdminDeleteComment extends AdminEvent {
  final String postId, commentId;

  AdminDeleteComment({required this.postId, required this.commentId});
}

class AdminDeleteRating extends AdminEvent {
  final String botanistId, ratingId;

  AdminDeleteRating({required this.botanistId, required this.ratingId});
}

class AdminBlockUser extends AdminEvent {
  final String uid;

  AdminBlockUser(this.uid);
}

class AdminUnblockUser extends AdminEvent {
  final String uid;

  AdminUnblockUser(this.uid);
}

class AdminIgnoreReport extends AdminEvent {
  final String collectionName;
  final String docId;

  AdminIgnoreReport({required this.collectionName, required this.docId});
}

class AdminGetReports extends AdminEvent {
  final String collection;
  final String docId;

  AdminGetReports({required this.collection, required this.docId});
}
