import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/community/domain/entities/community_post.dart';

import '../logic/community_bloc/community_bloc.dart';
import 'comments_list.dart';
import 'sample_comment.dart';
import 'write_a_comment.dart';

class CommunityPostDetailsScreen extends StatelessWidget {
  const CommunityPostDetailsScreen(this._post, {Key? key}) : super(key: key);

  final CommunityPost _post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
        actions: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              child: Text('Report'),
            ),
            onTap: () => showDialog(
              context: context,
              builder: (_) {
                final controller = TextEditingController();
                return AlertDialog(
                  title: Text('Report Post'),
                  content: TextField(
                    autofocus: false,
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: 'Reason for reporting',
                      contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    ),
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
                          // context
                          //     .read<IdentificationBloc>()
                          //     .add(IdentificationDownloadFromUrlPressed(controller.text.trim()));

                          Navigator.of(context).pop();
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(_post.imageUrl!),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(150),
                            child: Image.network(
                              _post.author.pictureUrl!,
                              height: 50,
                              width: 50,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _post.author.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                _post.time,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (_post.category != null) Chip(label: Text(_post.category ?? '')),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        _post.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                _post.description,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.comment),
                                SizedBox(width: 10),
                                Text(
                                  'Comments',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            CommentsList(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          WriteAComment(),
        ],
      ),
    );
  }
}
