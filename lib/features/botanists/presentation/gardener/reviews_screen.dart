import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/botanists/presentation/gardener/components/sample_review_item.dart';
import 'package:plants_buddy/features/botanists/presentation/gardener/components/write_a_review_sheet.dart';

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
              return Center(child: CircularProgressIndicator());

            case BotanistReviewsStatus.loaded:
              return state.reviews.isNotEmpty
                  ? SingleChildScrollView(
                      child: Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  Text(
                                    '${state.reviews.length} Review${state.reviews.length == 1 ? '' : 's'}',
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Spacer(),
                                  Text(
                                    state.reviewsAverage,
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.star,
                                    color: Colors.orangeAccent,
                                    size: 28,
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
                              itemBuilder: (context, index) => SampleReviewItem(
                                review: state.reviews[index],
                                botanist: state.botanist,
                              ),
                              itemCount: state.reviews.length,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(child: Text('No reviews yet'));
          }
        },
      ),
      floatingActionButton: FirebaseAuth.instance.currentUser != null
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (_) => BlocProvider.value(
                  value: context.read<BotanistReviewsBloc>(),
                  child: WriteAReview(),
                ),
              ),
            )
          : null,
    );
  }
}
