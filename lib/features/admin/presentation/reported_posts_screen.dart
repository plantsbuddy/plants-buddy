import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/admin_bloc.dart';
import 'sample_reported_post.dart';

class ReportedPostsScreen extends StatelessWidget {
  const ReportedPostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reported Posts'),
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (false) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => SampleReportedPost(),
              itemCount: 1,
              padding: EdgeInsets.symmetric(horizontal: 20),
            );
          }
        },
      ),
    );
  }
}
