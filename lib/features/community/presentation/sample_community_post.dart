import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as routes;
import 'package:plants_buddy/features/community/domain/entities/community_post.dart';
import 'package:plants_buddy/features/community/logic/community_bloc/community_bloc.dart';

import 'my_post_popup.dart';

class SampleCommunityPost extends StatelessWidget {
  const SampleCommunityPost(this._post, {Key? key}) : super(key: key);

  final CommunityPost _post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(routes.communityPostDetails, arguments: _post),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_post.category != null)
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[300],
                    ),
                    child: Text(_post.category!),
                  ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        _post.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ),
                    Text(
                      _post.timeAgo,
                      style: TextStyle(color: Colors.black54),
                    ),
                    if (context.read<CommunityBloc>().state.showOnlyMyPosts) MyPostPopup(_post),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  _post.description,
                  style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 13),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10),
                if (_post.imageUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      _post.imageUrl!,
                    ),
                  ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.comment,
                      color: Colors.black54,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${_post.commentsCount} ${_post.commentsCount == 1 ? 'Comment' : 'Comments'}',
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        'by ${_post.author.name}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.black38, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
