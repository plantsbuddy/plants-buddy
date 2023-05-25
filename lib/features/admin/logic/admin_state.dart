part of 'admin_bloc.dart';

enum AdminDataStatus { loading, loaded }

@immutable
class AdminState extends Equatable {
  final List<Map<String, dynamic>> reportedPosts;
  final AdminDataStatus reportedPostsStatus;
  final List<Map<String, dynamic>> reportedComments;
  final AdminDataStatus reportedCommentsStatus;
  final List<Map<String, dynamic>> reportedRatings;
  final AdminDataStatus reportedRatingsStatus;
  final List<Map<String, dynamic>> blockedUsers;
  final AdminDataStatus blockedUsersStatus;
  final List<Map<String, dynamic>> reportedBotanists;
  final AdminDataStatus reportedBotanistsStatus;
  final List<Report> reports;
  final AdminDataStatus reportsStatus;

  AdminState({
    this.reportedPosts = const [],
    this.reportedPostsStatus = AdminDataStatus.loading,
    this.reportedComments = const [],
    this.reportedCommentsStatus = AdminDataStatus.loading,
    this.reportedRatings = const [],
    this.reportedRatingsStatus = AdminDataStatus.loading,
    this.blockedUsers = const [],
    this.blockedUsersStatus = AdminDataStatus.loading,
    this.reportedBotanists = const [],
    this.reportedBotanistsStatus = AdminDataStatus.loading,
    this.reports = const [],
    this.reportsStatus = AdminDataStatus.loading,
  });

  AdminState copyWith({
    List<Map<String, dynamic>>? reportedPosts,
    AdminDataStatus? reportedPostsStatus,
    List<Map<String, dynamic>>? reportedComments,
    AdminDataStatus? reportedCommentsStatus,
    List<Map<String, dynamic>>? reportedRatings,
    AdminDataStatus? reportedRatingsStatus,
    List<Map<String, dynamic>>? blockedUsers,
    AdminDataStatus? blockedUsersStatus,
    List<Map<String, dynamic>>? reportedBotanists,
    AdminDataStatus? reportedBotanistsStatus,
    List<Report>? reports,
    AdminDataStatus? reportsStatus,
  }) =>
      AdminState(
        reportedPosts: reportedPosts ?? this.reportedPosts,
        reportedPostsStatus: reportedPostsStatus ?? this.reportedPostsStatus,
        reportedComments: reportedComments ?? this.reportedComments,
        reportedCommentsStatus: reportedCommentsStatus ?? this.reportedCommentsStatus,
        reportedRatings: reportedRatings ?? this.reportedRatings,
        reportedRatingsStatus: reportedRatingsStatus ?? this.reportedRatingsStatus,
        blockedUsers: blockedUsers ?? this.blockedUsers,
        blockedUsersStatus: blockedUsersStatus ?? this.blockedUsersStatus,
        reportedBotanists: reportedBotanists ?? this.reportedBotanists,
        reportedBotanistsStatus: reportedBotanistsStatus ?? this.reportedBotanistsStatus,
        reports: reports ?? this.reports,
        reportsStatus: reportsStatus ?? this.reportsStatus,
      );

  @override
  List<Object?> get props => [
        reportedPosts,
        reportedPostsStatus,
        reportedComments,
        reportedCommentsStatus,
        reportedRatings,
        reportedRatingsStatus,
        blockedUsers,
        blockedUsersStatus,
        reportedBotanists,
        reportedBotanistsStatus,
        reports,
        reportsStatus,
      ];
}
