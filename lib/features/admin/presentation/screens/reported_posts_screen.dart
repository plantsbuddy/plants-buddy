import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/admin_bloc.dart';
import '../components/no_reports.dart';
import '../components/sample_reported_post.dart';

class ReportedPostsScreen extends StatelessWidget {
  const ReportedPostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reported Posts'),
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        buildWhen: (previous, current) =>
            (previous.reportedPosts.length != current.reportedPosts.length) ||
            previous.reportedPostsStatus != current.reportedPostsStatus,
        builder: (context, state) {
          if (state.reportedPostsStatus == AdminDataStatus.loading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return state.reportedPosts.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) => SampleReportedPost(state.reportedPosts[index]),
                    itemCount: state.reportedPosts.length,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  )
                : NoReports(
                    title: 'No Reported Posts',
                    subtitle: 'No community posts have been reported yet. Once reported, they will appear here.',
                  );
          }
        },
      ),
    );
  }
}
