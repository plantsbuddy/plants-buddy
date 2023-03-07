import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plants_buddy/core/utils/custom_icons.dart' as custom_icons;

class NoCommunityPosts extends StatelessWidget {
  const NoCommunityPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 100),
        SvgPicture.asset(
          custom_icons.noCommunityPosts,
          height: 100,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'No posts in community',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Text(
          'Click the + button to add a new post to the community section',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
