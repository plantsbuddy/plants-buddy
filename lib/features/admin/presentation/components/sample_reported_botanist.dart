import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/domain/entities/botanist.dart';
import '../../logic/admin_bloc.dart';
import '../botanist_details_screen_admin.dart';
import '../reports_bottom_sheet.dart';

class SampleReportedBotanist extends StatelessWidget {
  const SampleReportedBotanist(this.details, {Key? key}) : super(key: key);

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
                'Botanist',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  foregroundColor: Theme.of(context).colorScheme.secondary,
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                ).copyWith(
                  elevation: ButtonStyleButton.allOrNull(0.0),
                ),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => BotanistDetailsScreenAdmin(details['botanist'] as Botanist),
                )),
                child: Text((details['botanist'] as Botanist).username),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                          content: Text('Are you sure you want to ignore the reports of this botanist?'),
                          actions: [
                            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel')),
                            TextButton(
                              onPressed: () {
                                context.read<AdminBloc>().add(AdminIgnoreReport(
                                      collectionName: 'reported_botanists',
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
                  SizedBox(width: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      foregroundColor: Theme.of(context).colorScheme.error,
                      backgroundColor: Theme.of(context).colorScheme.errorContainer,
                    ).copyWith(
                      elevation: ButtonStyleButton.allOrNull(0.0),
                    ),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text('Confirm block'),
                          content: Text('Are you sure you want to block this botanist from using the app?'),
                          actions: [
                            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel')),
                            TextButton(
                              onPressed: () {
                                context.read<AdminBloc>().add(AdminBlockUser(details['id']));

                                Navigator.of(context).pop();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Botanist blocked!'),
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
                    child: Text('Block botanist'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        context.read<AdminBloc>().add(AdminGetReports(collection: 'reported_botanists', docId: details['id']));

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
