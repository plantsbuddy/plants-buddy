import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plants_buddy/core/utils/custom_icons.dart';

import '../logic/community_bloc/community_bloc.dart';
import 'empty_community_search.dart';
import 'loading_community_posts.dart';
import 'no_community_posts.dart';
import 'sample_community_post.dart';

class CommunityPostsList extends StatelessWidget {
  const CommunityPostsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<CommunityBloc, CommunityState>(
        builder: (context, state) {
          switch (state.status) {
            case CommunityStatus.loading:
              return LoadingCommunityPosts();

            case CommunityStatus.loaded:
              return state.posts.isNotEmpty
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        return SampleCommunityPost(state.posts[index]);
                      },
                      itemCount: state.posts.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    )
                  : NoCommunityPosts();

            case CommunityStatus.notFound:
              return EmptyCommunitySearch();
          }
        },
      ),
    );
  }
}
