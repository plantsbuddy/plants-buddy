part of 'community_bloc.dart';

enum CommunityStatus { loading, loaded, notFound }

class CommunityState extends Equatable {
  final bool showOnlyMyPosts;
  final List<CommunityPost> _posts;
  final String? searchTerm;

  final bool onlyCommentsIsChecked;
  final bool newestFirst;
  final String selectedCategory;

  final CommunityStatus status;

  const CommunityState.initial()
      : _posts = const [],
        status = CommunityStatus.loading,
        searchTerm = null,
        showOnlyMyPosts = false,
        onlyCommentsIsChecked = false,
        newestFirst = true,
        selectedCategory = 'All';

  const CommunityState({
    required List<CommunityPost> posts,
    required this.status,
    required this.showOnlyMyPosts,
    required this.searchTerm,
    required this.onlyCommentsIsChecked,
    required this.newestFirst,
    required this.selectedCategory,
  }) : _posts = posts;

  List<CommunityPost> get posts {
    final List<CommunityPost> posts = _posts.where((post) {
      bool pass = true;

      if (onlyCommentsIsChecked) {
        pass = post.commentsCount! > 0;
      }

      if (selectedCategory != 'All') {
        if (post.category == null) {
          pass = true;
        } else {
          pass = post.category == selectedCategory;
        }
      }

      return pass;
    }).toList();

    return newestFirst ? posts : posts.reversed.toList();
  }

  CommunityState copyWith({
    List<CommunityPost>? posts,
    CommunityStatus? status,
    bool? showOnlyMyPosts,
    String? Function()? searchTerm,
    bool? onlyCommentsIsChecked,
    bool? newestFirst,
    String? selectedCategory,
  }) =>
      CommunityState(
        posts: posts ?? _posts,
        status: status ?? this.status,
        showOnlyMyPosts: showOnlyMyPosts ?? this.showOnlyMyPosts,
        searchTerm: searchTerm == null ? this.searchTerm : searchTerm(),
        newestFirst: newestFirst ?? this.newestFirst,
        onlyCommentsIsChecked: onlyCommentsIsChecked ?? this.onlyCommentsIsChecked,
        selectedCategory: selectedCategory ?? this.selectedCategory,
      );

  @override
  List<Object?> get props => [
        _posts,
        status,
        showOnlyMyPosts,
        searchTerm,
        newestFirst,
        onlyCommentsIsChecked,
        selectedCategory,
      ];
}
