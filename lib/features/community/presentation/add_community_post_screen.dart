import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/community/logic/add_community_post_bloc/add_community_post_bloc.dart';

import 'add_an_image.dart';
import 'post_categories_list.dart';

class AddCommunityPostScreen extends StatelessWidget {
  const AddCommunityPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: BlocConsumer<AddCommunityPostBloc, AddCommunityPostState>(
        listener: (context, state) {
          if (state.dialogShowing) {
            showDialog(
              context: context,
              builder: (context) {
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
                        Text(state.originalPost == null ? 'Creating post...' : 'Updating post...'),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            Future.delayed(const Duration(milliseconds: 200), () => Navigator.of(context).pop());

            if (state.titleError == null && state.descriptionError == null) {
              Navigator.of(context).pop();
            }
          }
        },
        listenWhen: (previous, current) => current.dialogShowing != previous.dialogShowing,
        builder: (context, state) {
          TextEditingController titleController = TextEditingController.fromValue(
              TextEditingValue(text: state.title, selection: TextSelection.collapsed(offset: state.title.length)));

          titleController.addListener(
              () => context.read<AddCommunityPostBloc>().add(AddCommunityPostTitleChanged(titleController.text)));

          TextEditingController descriptionController = TextEditingController.fromValue(TextEditingValue(
              text: state.description, selection: TextSelection.collapsed(offset: state.description.length)));

          descriptionController.addListener(() =>
              context.read<AddCommunityPostBloc>().add(AddCommunityPostDescriptionChanged(descriptionController.text)));

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  TextField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      errorText: state.titleError,
                      contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    ),
                  ),
                  PostCategoriesList(),
                  TextField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: descriptionController,
                    maxLines: 4,
                    minLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      errorText: state.descriptionError,
                      contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    ),
                  ),
                  AddAnImage(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();

                        context.read<AddCommunityPostBloc>().add(AddCommunityPostPressed());
                      },
                      child: Text(state.originalPost == null ? 'Create post' : 'Update post'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
