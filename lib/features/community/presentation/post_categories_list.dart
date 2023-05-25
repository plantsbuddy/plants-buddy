import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/community/logic/add_community_post_bloc/add_community_post_bloc.dart';

class PostCategoriesList extends StatelessWidget {
  const PostCategoriesList({Key? key}) : super(key: key);

  final _categories = const [
    'Question',
    'Identification Request',
    'Suggestion',
    'News',
    'Discussion',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 70,
        child: BlocBuilder<AddCommunityPostBloc, AddCommunityPostState>(
          builder: (context, state) {
            return ListView.builder(
              itemBuilder: (context, index) {
                bool isSelected = state.category == _categories[index];
                return _SampleCategory(category: _categories[index], isSelected: isSelected);
              },
              shrinkWrap: true,
              itemCount: _categories.length,
              scrollDirection: Axis.horizontal,
            );
          },
        ),
      ),
    );
  }
}

class _SampleCategory extends StatelessWidget {
  const _SampleCategory({required String category, required bool isSelected, Key? key})
      : _category = category,
        _isSelected = isSelected,
        super(key: key);

  final String _category;
  final bool _isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        child: Chip(
          backgroundColor: _isSelected ? Theme.of(context).colorScheme.inversePrimary : null,
          label: Text(_category),
        ),
        onTap: () => context.read<AddCommunityPostBloc>().add(AddCommunityPostCategoryToggled(_category)),
      ),
    );
  }
}
