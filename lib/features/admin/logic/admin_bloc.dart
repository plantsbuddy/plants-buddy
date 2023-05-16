import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../domain/usecases/admin_usecases.dart';

part 'admin_event.dart';

part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final BlockUser _blockUser;
  final DeleteReportedComment _deleteReportedComment;
  final DeleteReportedPost _deleteReportedPost;
  final DeleteReportedBotanistRating _deleteReportedBotanistRating;
  final GetReportedCommentsStream _getReportedCommentsStream;
  final GetReportedPostsStream _getReportedPostsStream;
  final GetReportedRatingsStream _getReportedRatingsStream;
  final GetBlockedUsersStream _getBlockedUsersStream;
  final UnblockUser _unblockUser;

  AdminBloc(
    this._blockUser,
    this._deleteReportedComment,
    this._deleteReportedPost,
    this._deleteReportedBotanistRating,
    this._getReportedCommentsStream,
    this._getReportedPostsStream,
    this._getReportedRatingsStream,
    this._getBlockedUsersStream,
    this._unblockUser,
  ) : super(AdminState()) {
    on<AdminBlockUser>(onAdminBlockUser);
    on<AdminInitializeReportedPostsStream>(onAdminInitializeReportedPostsStream);
    on<AdminInitializeReportedCommentsStream>(onAdminInitializeReportedCommentsStream);
    on<AdminInitializeReportedRatingsStream>(onAdminInitializeReportedRatingsStream);
    on<AdminInitializeBlockedUsersStream>(onAdminInitializeBlockedUsersStream);
    on<AdminDeletePost>(onAdminDeletePost);
    on<AdminDeleteComment>(onAdminDeleteComment);
    on<AdminDeleteRating>(onAdminDeleteRating);
    on<AdminUnblockUser>(onAdminUnblockUser);
  }

  FutureOr<void> onAdminBlockUser(AdminBlockUser event, Emitter<AdminState> emit) async {
    await _blockUser(event.uid);
  }

  FutureOr<void> onAdminInitializeReportedPostsStream(
      AdminInitializeReportedPostsStream event, Emitter<AdminState> emit) async {
    final reportedPostsStream = await _getReportedPostsStream();

    emit.forEach(
      reportedPostsStream,
      onData: (reportedPosts) =>
          state.copyWith(reportedPosts: reportedPosts, reportedPostsStatus: AdminDataStatus.loaded),
    );
  }

  FutureOr<void> onAdminInitializeReportedCommentsStream(
      AdminInitializeReportedCommentsStream event, Emitter<AdminState> emit) async {
    final reportedCommentsStream = await _getReportedCommentsStream();

    emit.forEach(
      reportedCommentsStream,
      onData: (reportedComments) =>
          state.copyWith(reportedComments: reportedComments, reportedCommentsStatus: AdminDataStatus.loaded),
    );
  }

  FutureOr<void> onAdminInitializeReportedRatingsStream(
      AdminInitializeReportedRatingsStream event, Emitter<AdminState> emit) async {
    final reportedRatingsStream = await _getReportedRatingsStream();

    emit.forEach(
      reportedRatingsStream,
      onData: (reportedRatings) =>
          state.copyWith(reportedRatings: reportedRatings, reportedRatingsStatus: AdminDataStatus.loaded),
    );
  }

  FutureOr<void> onAdminInitializeBlockedUsersStream(
      AdminInitializeBlockedUsersStream event, Emitter<AdminState> emit) async {
    final blockedUsersStream = await _getBlockedUsersStream();

    emit.forEach(
      blockedUsersStream,
      onData: (blockedUsers) => state.copyWith(blockedUsers: blockedUsers, blockedUsersStatus: AdminDataStatus.loaded),
    );
  }

  FutureOr<void> onAdminDeletePost(AdminDeletePost event, Emitter<AdminState> emit) async {
    await _deleteReportedPost(event.id);
  }

  FutureOr<void> onAdminDeleteComment(AdminDeleteComment event, Emitter<AdminState> emit) async {
    await _deleteReportedComment(commentId: event.commentId, postId: event.postId);
  }

  FutureOr<void> onAdminDeleteRating(AdminDeleteRating event, Emitter<AdminState> emit) async {
    await _deleteReportedBotanistRating(botanistId: event.botanistId, ratingId: event.ratingId);
  }

  FutureOr<void> onAdminUnblockUser(AdminUnblockUser event, Emitter<AdminState> emit) async {
    await _unblockUser(event.uid);
  }
}
