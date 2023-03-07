import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/community_bloc/community_bloc.dart';

class MyPostsScreen extends StatelessWidget {
  const MyPostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Posts'),
      ),
      body: BlocBuilder<CommunityBloc, CommunityState>(
        builder: (context, state) {
          switch (state.status) {
            case CommunityStatus.loading:
              return CircularProgressIndicator();

            case CommunityStatus.loaded:
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Container();
                },
              );

            case CommunityStatus.notFound:
              return Container();
          }
        },
      ),
    );
  }
}
