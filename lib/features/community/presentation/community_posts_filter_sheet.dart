import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/community/logic/community_bloc/community_bloc.dart';

class CommunityPostsFilterSheet extends StatefulWidget {
  const CommunityPostsFilterSheet({Key? key}) : super(key: key);

  @override
  State<CommunityPostsFilterSheet> createState() => _CommunityPostsFilterSheetState();
}

class _CommunityPostsFilterSheetState extends State<CommunityPostsFilterSheet> {
  late bool onlyCommentsIsChecked;
  late bool newestFirst;
  late int selectedCategoryIndex;

  final categories = const [
    'All',
    'Question',
    'Identification Request',
    'Suggestion',
    'News',
    'Discussion',
  ];

  @override
  void initState() {
    final state = context.read<CommunityBloc>().state;
    onlyCommentsIsChecked = state.onlyCommentsIsChecked;
    newestFirst = state.newestFirst;
    selectedCategoryIndex = categories.indexOf(state.selectedCategory);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                'Filter Posts',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 15),
              Text('Sort posts'),
              SizedBox(height: 5),
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
                      backgroundColor: newestFirst ? Theme.of(context).colorScheme.primaryContainer : Colors.grey[300],
                    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                    onPressed: () => setState(() => newestFirst = true),
                    child: Text('Newest first'),
                  ),
                  SizedBox(width: 15),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
                      backgroundColor: newestFirst ? Colors.grey[300] : Theme.of(context).colorScheme.primaryContainer,
                    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                    onPressed: () => setState(() => newestFirst = false),
                    child: Text('Older first'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Show posts of particular category'),
              SizedBox(
                height: 70,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: GestureDetector(
                        child: Chip(
                          backgroundColor:
                              index == selectedCategoryIndex ? Theme.of(context).colorScheme.inversePrimary : null,
                          label: Text(categories[index]),
                        ),
                        onTap: () => setState(() => selectedCategoryIndex = index),
                      ),
                    );
                  },
                  shrinkWrap: true,
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                child: Row(
                  children: [
                    Expanded(
                      child: Text('Show commented posts only'),
                    ),
                    Checkbox(
                      value: onlyCommentsIsChecked,
                      onChanged: (_) => setState(() => onlyCommentsIsChecked = !onlyCommentsIsChecked),
                    ),
                  ],
                ),
                onTap: () => setState(() => onlyCommentsIsChecked = !onlyCommentsIsChecked),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<CommunityBloc>().add(CommunityPostsApplyFilterPressed(
                          onlyCommentsIsChecked: onlyCommentsIsChecked,
                          newestFirst: newestFirst,
                          selectedCategory: categories[selectedCategoryIndex],
                        ));

                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: Text('Apply Filters'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
