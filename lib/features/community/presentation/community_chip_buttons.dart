import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/community_bloc/community_bloc.dart';
import 'community_posts_filter_sheet.dart';

class CommunityChipButtons extends StatelessWidget {
  const CommunityChipButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityBloc, CommunityState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 7, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
                  backgroundColor:
                      state.showOnlyMyPosts ? Theme.of(context).colorScheme.primaryContainer : Colors.grey[300],
                ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                onPressed: () => context.read<CommunityBloc>().add(CommunityMyPostsToggled()),
                child: Text('My Posts'),
              ),
              SizedBox(width: 7),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                onPressed: () => showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (_) => BlocProvider.value(
                    value: context.read<CommunityBloc>(),
                    child: CommunityPostsFilterSheet(),
                  ),
                ),
                label: Text('Filters'),
                icon: Icon(Icons.filter_list_outlined),
              ),
            ],
          ),
        );
      },
    );
  }
}
