import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../domain/entities/botanist_review.dart';

class SampleReviewItem extends StatelessWidget {
  const SampleReviewItem(this.review, {Key? key}) : super(key: key);

  final BotanistReview review;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 13),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image.network(
                    review.author!.profilePicture,
                    height: 45,
                    fit: BoxFit.cover,
                    width: 45,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review.author!.username,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            for (int i = 0; i < 4; i++)
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.orange,
                              ),
                            SizedBox(width: 10),
                            Text(
                              review.stars.toString(),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Spacer(),
                            Text(
                              review.timeAgo,
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              review.review,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
