import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/community/logic/community_post_bloc/community_post_bloc.dart';

import 'sample_comment.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityPostBloc, CommunityPostState>(
      builder: (context, state) {
        switch (state.status) {
          case CommunityPostCommentsStatus.loading:
            return Text('Loading...');

          case CommunityPostCommentsStatus.loaded:
            return state.comments.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) => SamplePostComment(state.comments[index]),
                    itemCount: state.comments.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  )
                : Column(
                    children: [
                      Text('No comments'),
                    ],
                  );
        }
      },
    );
  }
}
