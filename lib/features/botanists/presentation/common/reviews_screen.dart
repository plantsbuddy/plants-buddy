import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/botanists/presentation/common/sample_review_item.dart';
import 'package:plants_buddy/features/botanists/presentation/common/write_a_review.dart';

import '../../logic/botanist_reviews_bloc/botanist_reviews_bloc.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
      ),
      body: BlocBuilder<BotanistReviewsBloc, BotanistReviewsState>(
        builder: (context, state) {
          switch (state.status) {
            case BotanistReviewsStatus.loading:
              return CircularProgressIndicator();

            case BotanistReviewsStatus.loaded:
              return state.reviews.isNotEmpty
                  ? Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) => SampleReviewItem(state.reviews[index]),
                            itemCount: state.reviews.length,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                        WriteAReview(),
                      ],
                    )
                  : Center(
                      child: Text('No reviews yet'),
                    );
          }
        },
      ),
    );
  }
}
