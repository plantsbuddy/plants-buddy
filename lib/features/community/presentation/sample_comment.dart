import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/community/domain/entities/community_post.dart';

import '../domain/entities/comment.dart';
import '../logic/community_post_bloc/community_post_bloc.dart';

class SamplePostComment extends StatelessWidget {
  const SamplePostComment({required this.comment, required this.post, Key? key}) : super(key: key);

  final CommunityPost post;
  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(150),
            child: Image.network(
              comment.author.pictureUrl,
              height: 30,
              width: 30,
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        comment.author.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Text(
                      comment.time,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.report,
                          size: 17,
                          color: Colors.grey,
                        ),
                      ),
                      onTap: () => showDialog(
                        context: context,
                        builder: (_) {
                          final controller = TextEditingController();
                          return AlertDialog(
                            title: Text('Report Comment'),
                            content: TextField(
                              autofocus: false,
                              controller: controller,
                              decoration: InputDecoration(
                                labelText: 'Reason for reporting',
                                contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              ),
                              textCapitalization: TextCapitalization.sentences,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('Cancel'),
                                style: TextButton.styleFrom(foregroundColor: Theme.of(context).hintColor),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (controller.text.trim().isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Please provide a reason for reporting...'),
                                        behavior: SnackBarBehavior.floating,
                                        duration: Duration(milliseconds: 1500),
                                      ),
                                    );
                                  } else {
                                    context.read<CommunityPostBloc>().add(CommunityPostReportComment(
                                        reportText: controller.text, post: post, comment: comment));

                                    Navigator.of(context).pop();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Comment reported!'),
                                        behavior: SnackBarBehavior.floating,
                                        duration: Duration(milliseconds: 1500),
                                      ),
                                    );
                                  }
                                },
                                child: Text('Report'),
                                style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.primary),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Text(
                  comment.body,
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
