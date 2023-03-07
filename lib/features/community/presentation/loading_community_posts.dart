import 'package:flutter/material.dart';

class LoadingCommunityPosts extends StatelessWidget {
  const LoadingCommunityPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 130),
        CircularProgressIndicator(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Text(
            'Loading posts...',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ],
    );
  }
}
