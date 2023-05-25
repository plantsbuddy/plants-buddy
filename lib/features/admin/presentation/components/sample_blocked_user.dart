import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/admin_bloc.dart';

class SampleBlockedUser extends StatelessWidget {
  const SampleBlockedUser(this.details, {Key? key}) : super(key: key);

  final Map<String, dynamic> details;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image.network(
                    details['pictureUrl'],
                    fit: BoxFit.cover,
                    width: 55,
                    height: 55,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        details['name'],
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        details['email'],
                        style: TextStyle(color: Theme.of(context).dividerColor.withOpacity(0.5)),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        (details['user_type'] as String).capitalize,
                        style: TextStyle(color: Theme.of(context).dividerColor.withOpacity(0.5)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                        title: Text('Confirm unblock'),
                        content: Text('Are you sure you want to unblock this user from using the app?'),
                        actions: [
                          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel')),
                          TextButton(
                            onPressed: () {
                              context.read<AdminBloc>().add(AdminUnblockUser(details['uid']));

                              Navigator.of(context).pop();

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('User unblocked!'),
                                  behavior: SnackBarBehavior.floating,
                                  duration: Duration(milliseconds: 1500),
                                ),
                              );
                            },
                            child: Text('Unblock'),
                            style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                          ),
                        ],
                      );
                    },
                  ),
                  child: Text('Unblock'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
