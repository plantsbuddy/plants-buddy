import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:plants_buddy/core/errors/exceptions.dart';

import '../../domain/entities/community_post.dart';
import '../../domain/usecases/community_usecases.dart';

part 'community_event.dart';

part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  final GetCommunityPostsStream _getCommunityPostsStream;
  final SearchCommunityPosts _searchCommunityPosts;
  final DeleteCommunityPost _deleteCommunityPost;

  CommunityBloc(
    this._getCommunityPostsStream,
    this._searchCommunityPosts,
    this._deleteCommunityPost,
  ) : super(CommunityState.initial()) {
    on<CommunityPostsStreamInitialize>(onCommunityPostsInitialize);
    on<CommunityMyPostsToggled>(onCommunityMyPostsToggled);
    on<CommunitySearchTermUpdated>(onCommunitySearchTermUpdated);
    on<CommunityDeletePostPressed>(onCommunityDeletePostPressed);
    on<CommunityPostsApplyFilterPressed>(onCommunityPostsApplyFilterPressed);
  }

  Future<FutureOr<void>> onCommunityPostsInitialize(_, Emitter<CommunityState> emit) async {
    await emit.forEach<List<CommunityPost>>(
      await _getCommunityPostsStream(myPostsOnly: state.showOnlyMyPosts),
      onData: (posts) {
        posts = state.showOnlyMyPosts
            ? posts.where((post) => post.author.uid == FirebaseAuth.instance.currentUser!.uid).toList()
            : posts;

        return state.copyWith(posts: posts, status: CommunityStatus.loaded);
      },
    );
  }

  FutureOr<void> onCommunityMyPostsToggled(CommunityMyPostsToggled event, Emitter<CommunityState> emit) async {
    emit(state.copyWith(
        status: CommunityStatus.loading, showOnlyMyPosts: !state.showOnlyMyPosts)); //, showOnlyMyPosts: true));

      add(CommunityPostsStreamInitialize());
  }

  Future<FutureOr<void>> onCommunitySearchTermUpdated(
      CommunitySearchTermUpdated event, Emitter<CommunityState> emit) async {
    emit(state.copyWith(status: CommunityStatus.loading));

    try {
      final posts = await _searchCommunityPosts(event.term);

      emit(state.copyWith(posts: posts, status: posts.isEmpty ? CommunityStatus.notFound : CommunityStatus.loaded));
    } on EmptyCommunitySearchTermException {
      add(CommunityPostsStreamInitialize());
    }
  }

  Future<FutureOr<void>> onCommunityDeletePostPressed(CommunityDeletePostPressed event, _) async {
    await _deleteCommunityPost(event.id);
  }

  FutureOr<void> onCommunityPostsApplyFilterPressed(
      CommunityPostsApplyFilterPressed event, Emitter<CommunityState> emit) {
    emit(state.copyWith(
      onlyCommentsIsChecked: event.onlyCommentsIsChecked,
      selectedCategory: event.selectedCategory,
      newestFirst: event.newestFirst,
    ));
  }
}
