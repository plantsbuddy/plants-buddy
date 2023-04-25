import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as app_routes;
import 'package:plants_buddy/features/collections/logic/collections_bloc/collections_bloc.dart';

import '../logic/add_plant_bloc/add_collection_bloc.dart';
import 'add_collection_sheet.dart';
import 'no_collections.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.zero,
        child: BlocBuilder<CollectionsBloc, CollectionsState>(
          builder: (context, state) {
            switch (state.status) {
              case CollectionsStatus.loading:
                return Center(child: CircularProgressIndicator());

              case CollectionsStatus.loaded:
                return state.collections.isNotEmpty
                    ? Expanded(
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, crossAxisSpacing: 10, childAspectRatio: 5 / 6, mainAxisSpacing: 15),
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                          itemBuilder: (context, index) => GestureDetector(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Image.network(
                                      state.collections[index].cover,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 5),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.grey.withOpacity(0.1),
                                            Colors.grey.withOpacity(0.6),
                                            Colors.grey.withOpacity(0.7),
                                            Colors.grey.withOpacity(0.8),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                      child: Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 5,
                                        child: SizedBox(
                                          height: 50,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                state.collections[index].name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(color: Colors.white.withOpacity(0.9)),
                                              ),
                                              Text(
                                                '${state.collections[index].plants.length} plants',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(color: Colors.white.withOpacity(0.7)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () => Navigator.of(context)
                                .pushNamed(app_routes.collectionPlants, arguments: state.collections[index]),
                          ),
                          semanticChildCount: 1,
                          itemCount: state.collections.length,
                        ),
                      )
                    : NoCollections();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (_) => BlocProvider.value(
            value: context.read<AddCollectionBloc>(),
            child: AddCollectionSheet(),
          ),
        ),
      ),
    );
  }
}
