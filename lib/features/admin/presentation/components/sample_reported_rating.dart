import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/admin_bloc.dart';
import '../reports_bottom_sheet.dart';

class SampleReportedRating extends StatelessWidget {
  const SampleReportedRating(this.details, {Key? key}) : super(key: key);

  final Map<String, dynamic> details;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rating',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                details['rating']['review'],
                style: TextStyle(color: Colors.black.withOpacity(0.75)),
              ),
              SizedBox(height: 10),
              Text(
                'Rating Author',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                details['author']['name'],
                style: TextStyle(color: Colors.black.withOpacity(0.75)),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Reports',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  )
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                      ).copyWith(
                        elevation: ButtonStyleButton.allOrNull(0.0),
                      ),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text('Confirm block'),
                            content:
                                Text('Are you sure you want to block the author of this rating from using the app?'),
                            actions: [
                              TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel')),
                              TextButton(
                                onPressed: () {
                                  context.read<AdminBloc>().add(AdminBlockUser(details['reviewer_id']));

                                  Navigator.of(context).pop();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Author blocked!'),
                                      behavior: SnackBarBehavior.floating,
                                      duration: Duration(milliseconds: 1500),
                                    ),
                                  );
                                },
                                child: Text('Block'),
                                style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                              ),
                            ],
                          );
                        },
                      ),
                      child: Text('Block Author'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        foregroundColor: Theme.of(context).colorScheme.error,
                        backgroundColor: Theme.of(context).colorScheme.errorContainer,
                      ).copyWith(
                        elevation: ButtonStyleButton.allOrNull(0.0),
                      ),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text('Confirm delete'),
                            content: Text('Are you sure you want to delete this rating from botanist\'s profile?'),
                            actions: [
                              TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel')),
                              TextButton(
                                onPressed: () {
                                  context.read<AdminBloc>().add(AdminDeleteRating(
                                      botanistId: details['botanist_id'], ratingId: details['reviewer_id']));

                                  Navigator.of(context).pop();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Rating deleted!'),
                                      behavior: SnackBarBehavior.floating,
                                      duration: Duration(milliseconds: 1500),
                                    ),
                                  );
                                },
                                child: Text('Delete'),
                                style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                              ),
                            ],
                          );
                        },
                      ),
                      child: Text('Delete'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        foregroundColor: Theme.of(context).colorScheme.inverseSurface,
                        backgroundColor: Theme.of(context).colorScheme.inverseSurface.withOpacity(0.15),
                      ).copyWith(
                        elevation: ButtonStyleButton.allOrNull(0.0),
                      ),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text('Confirm ignore'),
                            content: Text(
                                'Are you sure you want to ignore the reports of this rating on botanist\'s profile?'),
                            actions: [
                              TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel')),
                              TextButton(
                                onPressed: () {
                                  context.read<AdminBloc>().add(AdminIgnoreReport(
                                        collectionName: 'reported_botanist_reviews',
                                        docId: details['id'],
                                      ));

                                  Navigator.of(context).pop();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Reports ignored and removed!'),
                                      behavior: SnackBarBehavior.floating,
                                      duration: Duration(milliseconds: 1500),
                                    ),
                                  );
                                },
                                child: Text('Ignore'),
                                style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                              ),
                            ],
                          );
                        },
                      ),
                      child: Text('Ignore'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        context.read<AdminBloc>().add(AdminGetReports(collection: 'reported_botanist_reviews', docId: details['id']));

        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          isDismissible: true,
          backgroundColor: Colors.transparent,
          builder: (_) => BlocProvider.value(
            value: context.read<AdminBloc>(),
            child: ReportsBottomSheet(),
          ),
        );
      },
    );
  }
}
