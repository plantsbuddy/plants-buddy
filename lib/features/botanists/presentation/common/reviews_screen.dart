import 'package:flutter/material.dart';
import 'package:plants_buddy/features/botanists/presentation/common/sample_review_item.dart';
import 'package:plants_buddy/features/botanists/presentation/common/write_a_review.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => SampleReviewItem(),
              itemCount: 5,
              padding: EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
          WriteAReview(),
        ],
      ),
    );
  }
}
