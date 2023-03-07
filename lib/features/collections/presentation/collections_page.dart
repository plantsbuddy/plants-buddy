import 'package:flutter/material.dart';
import 'package:plants_buddy/features/community/presentation/community_search_box.dart';

import 'sample_collection.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: CommunitySearchBox(),
            ),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: 5 / 6,
              mainAxisSpacing: 15,
              children: [
                SampleCollection(),
                SampleCollection(),
                SampleCollection(),
                SampleCollection(),
                SampleCollection(),
                SampleCollection(),
              ],
              semanticChildCount: 1,
            ),
          ],
        ),
      ),
    );
  }
}
