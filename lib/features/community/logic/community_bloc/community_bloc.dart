import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:plants_buddy/core/errors/exceptions.dart';

import '../../domain/entities/community_post.dart';
import '../../domain/usecases/community_usecases.dart';

part 'community_event.dart';

part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  final GetCommunityPostsStream _getCommunityPostsStream;
  final GetMyCommunityPosts _getMyCommunityPosts;
  final SearchCommunityPosts _searchCommunityPosts;
  final DeleteCommunityPost _deleteCommunityPost;

  CommunityBloc(
    this._getCommunityPostsStream,
    this._getMyCommunityPosts,
    this._searchCommunityPosts,
    this._deleteCommunityPost,
  ) : super(CommunityState.initial()) {
    on<CommunityPostsStreamInitialize>(onCommunityPostsInitialize);
    on<CommunityMyPostsToggled>(onCommunityMyPostsToggled);
    on<CommunitySearchTermUpdated>(onCommunitySearchTermUpdated);
    on<CommunityDeletePostPressed>(onCommunityDeletePostPressed);
  }

  Future<FutureOr<void>> onCommunityPostsInitialize(_, Emitter<CommunityState> emit) async {
    await emit.forEach<List<CommunityPost>>(
      await _getCommunityPostsStream(),
      onData: (posts) {
        return state.copyWith(posts: posts, status: CommunityStatus.loaded);
      },
    );
  }

  FutureOr<void> onCommunityMyPostsToggled(CommunityMyPostsToggled event, Emitter<CommunityState> emit) async {
    emit(state.copyWith(
        status: CommunityStatus.loading, showOnlyMyPosts: !state.showOnlyMyPosts)); //, showOnlyMyPosts: true));

    if (state.showOnlyMyPosts) {
      // State is already set to showOnlyMyPosts
      final myPosts = await _getMyCommunityPosts();
      emit(state.copyWith(status: CommunityStatus.loaded, posts: myPosts));
    } else {
      add(CommunityPostsStreamInitialize());
    }
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

  Future<FutureOr<void>> onCommunityDeletePostPressed(
      CommunityDeletePostPressed event, Emitter<CommunityState> emit) async {
    await _deleteCommunityPost(event.id);
  }
}
