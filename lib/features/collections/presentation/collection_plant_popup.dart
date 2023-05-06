import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as routes;
import 'package:plants_buddy/features/collections/logic/collection_plants_bloc/collection_plants_bloc.dart';

import '../domain/entities/collection_plant.dart';

class CollectionPlantPopup extends StatelessWidget {
  const CollectionPlantPopup(this.plant, {Key? key}) : super(key: key);

  final CollectionPlant plant;

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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onSelected: (option) {
        if (option == 1) {
          Navigator.of(context).pushNamed(routes.addPlantToCollection, arguments: {
            'collection': context.read<CollectionPlantsBloc>().state.collection,
            'original_plant': plant
          });
        } else if (option == 2) {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('Confirm delete'),
                content: Text('Are you sure you want to delete this plant from the collection?'),
                actions: [
                  TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel')),
                  TextButton(
                    onPressed: () {
                      context.read<CollectionPlantsBloc>().add(CollectionPlantsDeletePlantPressed(plant));
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Deleting plant...'),
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
