import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/botanists/logic/botanist_reviews_bloc/botanist_reviews_bloc.dart';
import 'package:plants_buddy/features/community/logic/community_post_bloc/community_post_bloc.dart';

class WriteAReview extends StatefulWidget {
  const WriteAReview({Key? key}) : super(key: key);

  @override
  State<WriteAReview> createState() => _WriteAReviewState();
}

class _WriteAReviewState extends State<WriteAReview> {
  int stars = 1;
  String? reviewError;
  late final TextEditingController _controller;
  bool starRatingErrorVisible = false;

  @override
  void initState() {
    _controller = TextEditingController(text: context.read<BotanistReviewsBloc>().state.alreadyPostedReview?.review);
    stars = context.read<BotanistReviewsBloc>().state.alreadyPostedReview?.stars ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BotanistReviewsBloc>();

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bloc.state.alreadyPostedReview == null ? 'Post Review' : 'Update Review',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.star,
                      color: stars > 0 ? Colors.orangeAccent : Colors.grey,
                    ),
                    onTap: () => setState(() => stars = 1),
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.star,
                      color: stars > 1 ? Colors.orangeAccent : Colors.grey,
                    ),
                    onTap: () => setState(() => stars = 2),
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.star,
                      color: stars > 2 ? Colors.orangeAccent : Colors.grey,
                    ),
                    onTap: () => setState(() => stars = 3),
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.star,
                      color: stars > 3 ? Colors.orangeAccent : Colors.grey,
                    ),
                    onTap: () => setState(() => stars = 4),
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.star,
                      color: stars > 4 ? Colors.orangeAccent : Colors.grey,
                    ),
                    onTap: () => setState(() => stars = 5),
                  ),
                ],
              ),
              SizedBox(height: 25),
              if (starRatingErrorVisible)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Please provide star rating',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              TextField(
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(
                  color: Colors.black54,
                  decoration: TextDecoration.none,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: 'Write a review...',
                  errorText: reviewError,
                ),
                controller: _controller,
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_controller.text.trim().isEmpty) {
                      setState(() => reviewError = 'Please write the review feedback');
                    } else if (stars == 0) {
                      setState(() => starRatingErrorVisible = true);
                    } else {
                      bloc.add(BotanistReviewsPostReview(review: _controller.text, stars: stars));

                      BuildContext? dialogContext;

                      showDialog(
                        context: context,
                        builder: (_) {
                          dialogContext = _;
                          return Dialog(
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                              child: Row(
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('${bloc.state.alreadyPostedReview == null ? 'Posting' : 'Updating'} review...'),
                                ],
                              ),
                            ),
                          );
                        },
                      );

                      Future.delayed(
                        Duration(milliseconds: 1500),
                        () {
                          Navigator.of(context).pop();
                          Navigator.of(dialogContext!).pop();
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: Text(bloc.state.alreadyPostedReview == null ? 'Add Review' : 'Update Review'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
