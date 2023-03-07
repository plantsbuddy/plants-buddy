import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plants_buddy/core/utils/custom_icons.dart' as custom_icons;

class EmptyCommunitySearch extends StatelessWidget {
  const EmptyCommunitySearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 100),
        SvgPicture.asset(
          custom_icons.emptyCommunitySearch,
          height: 100,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'No matching posts found',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Text(
          'No matching posts were found for your searched term',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
