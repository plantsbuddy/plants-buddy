import 'package:flutter/material.dart';
import 'package:plants_buddy/features/suggestions/presentation/guides_page.dart';

import 'suggestions_page.dart';

class SuggestionsScreen extends StatefulWidget {
  const SuggestionsScreen({Key? key}) : super(key: key);

  @override
  State<SuggestionsScreen> createState() => _SuggestionsScreenState();
}

class _SuggestionsScreenState extends State<SuggestionsScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentPage == 0 ? 'Weather Based Suggestions' : 'Plantation Guides'),
      ),
      body: currentPage == 0 ? SuggestionsPage() : GuidesPage(),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.info_outline), label: 'Suggestions'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), label: 'Guides'),
        ],
        selectedIndex: currentPage,
        onDestinationSelected: (index) => setState(() => currentPage = index),
      ),
    );
  }
}
