import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/community/logic/add_community_post_bloc/add_community_post_bloc.dart';
import 'package:plants_buddy/features/community/logic/add_community_post_bloc/add_community_post_bloc.dart';

class CommunityPostImage extends StatelessWidget {
  const CommunityPostImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 25),
        child: BlocBuilder<AddCommunityPostBloc, AddCommunityPostState>(
          builder: (context, state) {
            return state.imageAttached
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: state.image != null
                            ? Image.file(File(state.image!))
                            : Image.network(state.originalPost!.imageUrl!),
                      ),
                      TextButton.icon(
                        icon: Icon(Icons.delete),
                        label: Text('Remove'),
                        style: TextButton.styleFrom(foregroundColor: Color(0xFFF73B5F)),
                        onPressed: () => context.read<AddCommunityPostBloc>().add(AddCommunityPostRemoveImagePressed()),
                      ),
                    ],
                  )
                : Card(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              color: Colors.black54,
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Add an image',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      borderRadius: BorderRadius.circular(11),
                      onTap: () => context.read<AddCommunityPostBloc>().add(AddCommunityPostAttachImagePressed()),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
