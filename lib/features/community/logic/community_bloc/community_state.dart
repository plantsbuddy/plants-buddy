part of 'community_bloc.dart';

enum CommunityStatus { loading, loaded, notFound }

class CommunityState extends Equatable {
  final bool showOnlyMyPosts;
  final List<CommunityPost> posts;

  //final List<CommunityPost> myPosts;
  final String? searchTerm;

  final CommunityStatus status;

  const CommunityState.initial()
      : posts = const [],
        //  myPosts = const [],
        status = CommunityStatus.loading,
        searchTerm = null,
        showOnlyMyPosts = false;

  const CommunityState({
    required this.posts,
    //  required this.myPosts,
    required this.status,
    required this.showOnlyMyPosts,
    required this.searchTerm,
  });

  CommunityState copyWith({
    List<CommunityPost>? posts,
   // List<CommunityPost>? myPosts,
    CommunityStatus? status,
    bool? showOnlyMyPosts,
    String? Function()? searchTerm,
  }) =>
      CommunityState(
        posts: posts ?? this.posts,
        //    myPosts: myPosts ?? this.myPosts,
        status: status ?? this.status,
        showOnlyMyPosts: showOnlyMyPosts ?? this.showOnlyMyPosts,
        searchTerm: searchTerm == null ? this.searchTerm : searchTerm(),
      );

  @override
  List<Object?> get props => [posts, status, showOnlyMyPosts, searchTerm];
}
