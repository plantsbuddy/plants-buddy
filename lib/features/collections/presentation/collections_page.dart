import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as app_routes;
import 'package:plants_buddy/features/collections/logic/collections_bloc/collections_bloc.dart';
import 'package:plants_buddy/features/collections/presentation/sample_collection.dart';

import '../logic/add_collection_bloc/add_collection_bloc.dart';
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
                          itemBuilder: (context, index) => SampleCollection(state.collections[index]),
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
