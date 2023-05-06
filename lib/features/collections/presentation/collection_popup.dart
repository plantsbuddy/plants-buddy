import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/collections/domain/entities/collection.dart';
import 'package:plants_buddy/features/collections/logic/collections_bloc/collections_bloc.dart';

import '../logic/add_collection_bloc/add_collection_bloc.dart';
import 'add_collection_sheet.dart';

class CollectionPopup extends StatelessWidget {
  const CollectionPopup(this.collection, {Key? key}) : super(key: key);

  final Collection collection;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Icon(
                Icons.edit,
                color: Color(0xFF6c6c6c),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Edit',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(
                Icons.delete,
                color: Color(0xFF6c6c6c),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Delete',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
      offset: Offset(0, 50),
      elevation: 10,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onSelected: (option) async {
        if (option == 1) {
          final bloc = context.read<AddCollectionBloc>();
          bloc.add(AddCollectionEditCollectionPressed(collection));

          await showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (_) => BlocProvider.value(
              value: bloc,
              child: AddCollectionSheet(),
            ),
          );

          bloc.add(AddCollectionEditCompleted());
        } else if (option == 2) {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('Confirm delete'),
                content: Text('Are you sure you want to delete this collection and its plants?'),
                actions: [
                  TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel')),
                  TextButton(
                    onPressed: () {
                      context.read<CollectionsBloc>().add(CollectionsDeleteCollectionPressed(collection));
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Deleting collection...'),
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
          );
        }
      },
    );
  }
}
