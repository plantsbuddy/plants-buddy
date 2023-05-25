import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../authentication/domain/entities/botanist.dart';
import '../domain/entities/report.dart';
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
  final GetReportedBotanistsStream _getReportedBotanistsStream;
  final GetBlockedUsersStream _getBlockedUsersStream;
  final GetReports _getReports;
  final IgnoreReport _ignoreReport;
  final UnblockUser _unblockUser;

  AdminBloc(
    this._blockUser,
    this._deleteReportedComment,
    this._deleteReportedPost,
    this._deleteReportedBotanistRating,
    this._getReportedCommentsStream,
    this._getReportedPostsStream,
    this._getReportedRatingsStream,
    this._getReportedBotanistsStream,
    this._getBlockedUsersStream,
    this._unblockUser,
    this._getReports,
    this._ignoreReport,
  ) : super(AdminState()) {
    on<AdminBlockUser>(onAdminBlockUser);
    on<AdminInitializeReportedPostsStream>(onAdminInitializeReportedPostsStream);
    on<AdminInitializeReportedCommentsStream>(onAdminInitializeReportedCommentsStream);
    on<AdminInitializeReportedRatingsStream>(onAdminInitializeReportedRatingsStream);
    on<AdminInitializeBlockedUsersStream>(onAdminInitializeBlockedUsersStream);
    on<AdminInitializeReportedBotanistsStream>(onAdminInitializeReportedBotanistsStream);
    on<AdminDeletePost>(onAdminDeletePost);
    on<AdminDeleteComment>(onAdminDeleteComment);
    on<AdminDeleteRating>(onAdminDeleteRating);
    on<AdminUnblockUser>(onAdminUnblockUser);
    on<AdminIgnoreReport>(onAdminIgnoreReport);
    on<AdminGetReports>(onAdminGetReports);
  }

  FutureOr<void> onAdminBlockUser(AdminBlockUser event, Emitter<AdminState> emit) async {
    await _blockUser(event.uid);
  }

  FutureOr<void> onAdminInitializeReportedPostsStream(
      AdminInitializeReportedPostsStream event, Emitter<AdminState> emit) async {
    final reportedPostsStream = await _getReportedPostsStream();

    await emit.forEach(
      reportedPostsStream,
      onData: (reportedPosts) =>
          state.copyWith(reportedPosts: reportedPosts, reportedPostsStatus: AdminDataStatus.loaded),
    );
  }

  FutureOr<void> onAdminInitializeReportedCommentsStream(
      AdminInitializeReportedCommentsStream event, Emitter<AdminState> emit) async {
    final reportedCommentsStream = await _getReportedCommentsStream();

    await emit.forEach(
      reportedCommentsStream,
      onData: (reportedComments) =>
          state.copyWith(reportedComments: reportedComments, reportedCommentsStatus: AdminDataStatus.loaded),
    );
  }

  FutureOr<void> onAdminInitializeReportedRatingsStream(
      AdminInitializeReportedRatingsStream event, Emitter<AdminState> emit) async {
    final reportedRatingsStream = await _getReportedRatingsStream();

    await emit.forEach(
      reportedRatingsStream,
      onData: (reportedRatings) =>
          state.copyWith(reportedRatings: reportedRatings, reportedRatingsStatus: AdminDataStatus.loaded),
    );
  }

  FutureOr<void> onAdminInitializeBlockedUsersStream(
      AdminInitializeBlockedUsersStream event, Emitter<AdminState> emit) async {
    final blockedUsersStream = await _getBlockedUsersStream();

    await emit.forEach(
      blockedUsersStream,
      onData: (blockedUsers) => state.copyWith(blockedUsers: blockedUsers, blockedUsersStatus: AdminDataStatus.loaded),
    );
  }

  FutureOr<void> onAdminInitializeReportedBotanistsStream(
      AdminInitializeReportedBotanistsStream event, Emitter<AdminState> emit) async {
    final reportedBotanistsStream = await _getReportedBotanistsStream();

    await emit.forEach(
      reportedBotanistsStream,
      onData: (reportedBotanists) =>
          state.copyWith(reportedBotanists: reportedBotanists, reportedBotanistsStatus: AdminDataStatus.loaded),
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

  FutureOr<void> onAdminIgnoreReport(AdminIgnoreReport event, Emitter<AdminState> emit) async {
    await _ignoreReport(collectionName: event.collectionName, docId: event.docId);
  }

  FutureOr<void> onAdminGetReports(AdminGetReports event, Emitter<AdminState> emit) async {
    emit(state.copyWith(reportsStatus: AdminDataStatus.loading, reports: []));

    final reports = await _getReports(collectionName: event.collection, docId: event.docId);

    emit(state.copyWith(reports: reports, reportsStatus: AdminDataStatus.loaded));
  }
}
