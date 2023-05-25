import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/botanists/logic/botanist_reviews_bloc/botanist_reviews_bloc.dart';

import '../../../../authentication/domain/entities/botanist.dart';
import '../../../domain/entities/botanist_review.dart';

class SampleReviewItem extends StatelessWidget {
  const SampleReviewItem({required this.review, required this.botanist, Key? key}) : super(key: key);

  final Botanist botanist;
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
                            if (FirebaseAuth.instance.currentUser != null)
                              GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Icon(
                                    Icons.report,
                                    size: 17,
                                    color: Colors.grey,
                                  ),
                                ),
                                onTap: () => showDialog(
                                  context: context,
                                  builder: (_) {
                                    final controller = TextEditingController();
                                    return AlertDialog(
                                      title: Text('Report Review'),
                                      content: TextField(
                                        autofocus: false,
                                        controller: controller,
                                        decoration: InputDecoration(
                                          labelText: 'Reason for reporting',
                                          contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        ),
                                        textCapitalization: TextCapitalization.sentences,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(),
                                          child: Text('Cancel'),
                                          style: TextButton.styleFrom(foregroundColor: Theme.of(context).hintColor),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            if (controller.text.trim().isEmpty) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('Please provide a reason for reporting...'),
                                                  behavior: SnackBarBehavior.floating,
                                                  duration: Duration(milliseconds: 1500),
                                                ),
                                              );
                                            } else {
                                              context.read<BotanistReviewsBloc>().add(BotanistReviewsReportReview(
                                                  reportText: controller.text, review: review, botanist: botanist));

                                              Navigator.of(context).pop();

                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('Review reported!'),
                                                  behavior: SnackBarBehavior.floating,
                                                  duration: Duration(milliseconds: 1500),
                                                ),
                                              );
                                            }
                                          },
                                          child: Text('Report'),
                                          style: TextButton.styleFrom(
                                              foregroundColor: Theme.of(context).colorScheme.primary),
                                        ),
                                      ],
                                    );
                                  },
                                ),
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
