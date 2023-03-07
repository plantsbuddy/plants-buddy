import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as routes;
import '../domain/entities/community_post.dart';
import '../logic/community_bloc/community_bloc.dart';
import 'community_chip_buttons.dart';
import 'community_posts_list.dart';
import 'community_search_box.dart';
import 'empty_community_search.dart';
import 'loading_community_posts.dart';
import 'sample_community_post.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              CommunitySearchBox(),
              CommunityChipButtons(),
              CommunityPostsList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed(routes.addCommunityPost),
      ),
    );
  }
}
