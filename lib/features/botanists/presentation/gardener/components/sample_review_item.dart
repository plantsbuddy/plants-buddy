import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../domain/entities/botanist_review.dart';

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
                    review.author!.pictureUrl!,
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
                        Row(
                          children: [
                            Text(
                              review.author!.name,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Spacer(),
                            Text(
                              review.timeAgo,
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 18,
                              color: review.stars > 0 ? Colors.orangeAccent : Colors.grey,
                            ),
                            Icon(
                              Icons.star,
                              size: 18,
                              color: review.stars > 1 ? Colors.orangeAccent : Colors.grey,
                            ),
                            Icon(
                              Icons.star,
                              size: 18,
                              color: review.stars > 2 ? Colors.orangeAccent : Colors.grey,
                            ),
                            Icon(
                              Icons.star,
                              size: 18,
                              color: review.stars > 3 ? Colors.orangeAccent : Colors.grey,
                            ),
                            Icon(
                              Icons.star,
                              size: 18,
                              color: review.stars > 4 ? Colors.orangeAccent : Colors.grey,
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
