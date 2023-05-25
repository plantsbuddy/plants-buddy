import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/admin_bloc.dart';
import '../components/no_reports.dart';
import '../components/sample_reported_comment.dart';

class ReportedCommentsScreen extends StatelessWidget {
  const ReportedCommentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reported Comments'),
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        buildWhen: (previous, current) =>
            (previous.reportedComments.length != current.reportedComments.length) ||
            previous.reportedCommentsStatus != current.reportedCommentsStatus,
        builder: (context, state) {
          if (state.reportedCommentsStatus == AdminDataStatus.loading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return state.reportedComments.isNotEmpty? ListView.builder(
              itemBuilder: (context, index) => SampleReportedComment(state.reportedComments[index]),
              itemCount: state.reportedComments.length,
              padding: EdgeInsets.symmetric(horizontal: 20),
            ): NoReports(
              title: 'No Reported Comments',
              subtitle: 'No comments of community posts have been reported yet. Once reported, they will appear here.',
            );
          }
        },
      ),
    );
  }
}
