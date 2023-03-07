import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/comment.dart';
import '../../domain/usecases/community_usecases.dart';

part 'community_post_event.dart';

part 'community_post_state.dart';

class CommunityPostBloc extends Bloc<CommunityPostEvent, CommunityPostState> {
  final GetPostCommentsStream _getPostCommentsStream;
  final AddComment _addComment;

  CommunityPostBloc(
    String postId,
    this._getPostCommentsStream,
    this._addComment,
  ) : super(CommunityPostState.initial(postId)) {
    on<CommunityPostCommentsStreamInitialize>(onCommunityPostCommentsStreamInitialize);
    on<CommunityPostAddComment>(onCommunityPostAddComment);
  }

  Future<FutureOr<void>> onCommunityPostCommentsStreamInitialize(
      CommunityPostCommentsStreamInitialize event, Emitter<CommunityPostState> emit) async {
    await emit.forEach<List<Comment>>(
      await _getPostCommentsStream(state.postId),
      onData: (comments) {
        return state.copyWith(comments: comments, status: CommunityPostCommentsStatus.loaded);
      },
    );
  }

  Future<FutureOr<void>> onCommunityPostAddComment(
      CommunityPostAddComment event, Emitter<CommunityPostState> emit) async {
    try {
      await _addComment(postId: state.postId, body: event.body);
    } on Exception {
      emit(state.copyWith(commentError: () => 'Please '));
    }
  }
}
