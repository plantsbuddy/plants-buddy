import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as app_routes;
import 'package:plants_buddy/core/utils/custom_icons.dart' as custom_icons;
import 'package:plants_buddy/features/admin/logic/admin_bloc.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: GridView.count(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.of(context).pushNamed(app_routes.reportedPosts, arguments: context.read<AdminBloc>()),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      custom_icons.reportedPosts,
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Divider(
                        height: 1,
                        thickness: 0.1,
                      ),
                    ),
                    Text(
                      'Reported\nPosts',
                      style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () =>
                Navigator.of(context).pushNamed(app_routes.reportedComments, arguments: context.read<AdminBloc>()),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      custom_icons.reportedComments,
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Divider(
                        height: 1,
                        thickness: 0.1,
                      ),
                    ),
                    Text(
                      'Reported\nComments',
                      style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () =>
                Navigator.of(context).pushNamed(app_routes.reportedRatings, arguments: context.read<AdminBloc>()),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      custom_icons.reportedRatings,
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Divider(
                        height: 1,
                        thickness: 0.1,
                      ),
                    ),
                    Text(
                      'Reported\nRatings',
                      style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () =>
                Navigator.of(context).pushNamed(app_routes.reportedBotanists, arguments: context.read<AdminBloc>()),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      custom_icons.reportedBotanists,
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Divider(
                        height: 1,
                        thickness: 0.1,
                      ),
                    ),
                    Text(
                      'Reported\nBotanists',
                      style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(app_routes.blockedUsers, arguments: context.read<AdminBloc>()),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      custom_icons.blockedUsers,
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Divider(
                        height: 1,
                        thickness: 0.1,
                      ),
                    ),
                    Text(
                      'Blocked\nUsers',
                      style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        crossAxisSpacing: 20,
        mainAxisSpacing: 25,
        crossAxisCount: 2,
      ),
    );
  }
}
