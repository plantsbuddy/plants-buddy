import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plants_buddy/core/utils/custom_icons.dart' as custom_icons;
import 'package:plants_buddy/features/collections/presentation/collections_page.dart';
import 'package:plants_buddy/features/community/presentation/community_screen.dart';
import 'package:plants_buddy/features/home/logic/home_cubit.dart';
import 'package:plants_buddy/features/home/presentation/home_page.dart';
import 'package:plants_buddy/features/reminders/presentation/reminders_page.dart';

import '../../../core/utils/strings.dart' as strings;
import 'more_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isBlockedDialogHidden = true;

  @override
  void initState() {
    listenForUserBlock(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = context.watch<HomeCubit>().state.currentPage;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 47,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SvgPicture.asset(
            custom_icons.plantsBuddy,
          ),
        ),
        title: Text(strings.plantsBuddy),
        //actions: _getActions(currentPage, context),
      ),
      body: _getPageView(currentPage),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.groups), label: 'Community'),
          NavigationDestination(icon: Icon(Icons.collections_bookmark), label: 'Collections'),
          NavigationDestination(icon: Icon(Icons.notifications_rounded), label: 'Reminders'),
          NavigationDestination(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
        selectedIndex: BottomNavPages.values.indexOf(currentPage),
        onDestinationSelected: (index) => context.read<HomeCubit>().bottomNavItemSelected(index),
      ),
    );
  }

  Widget _getPageView(BottomNavPages currentPage) {
    switch (currentPage) {
      case BottomNavPages.home:
        return HomePage();
      case BottomNavPages.community:
        return CommunityPage();
      case BottomNavPages.collections:
        return CollectionsPage();
      case BottomNavPages.reminders:
        return RemindersPage();
      case BottomNavPages.more:
        return MorePage();
    }
  }

  List<Widget>? _getActions(BottomNavPages currentPage, BuildContext context) {
    switch (currentPage) {
      case BottomNavPages.home:
        // TODO: Handle this case.
        break;
      case BottomNavPages.community:
        return [
          Center(
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: () => {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  'My posts',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ),
        ];
      case BottomNavPages.collections:
        break;
      case BottomNavPages.reminders:
        // TODO: Handle this case.
        break;
      case BottomNavPages.more:
        break;
    }
  }

  void listenForUserBlock(BuildContext context) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((snapshot) {
      final isBlocked = snapshot.get('blocked') as bool;

      if (isBlocked && isBlockedDialogHidden) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return AlertDialog(
              title: Text('You got blocked'),
              content: Text(
                  'You have been blocked by an admin from using the app, due to the violation of community guidelines of the app'),
              actions: [
                TextButton(
                  onPressed: () async {
                    setState(() => isBlockedDialogHidden = true);
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pop();
                  },
                  child: Text('Okay'),
                  style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                ),
              ],
            );
          },
        );

        setState(() => isBlockedDialogHidden = false);
      }
    });
  }
}
