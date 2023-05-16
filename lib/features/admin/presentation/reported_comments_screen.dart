import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/admin_bloc.dart';
import 'sample_reported_comment.dart';

class ReportedCommentsScreen extends StatelessWidget {
  const ReportedCommentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reported Comments'),
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (false) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => SampleReportedComment(),
              itemCount: 1,
              padding: EdgeInsets.symmetric(horizontal: 20),
            );
          }
        },
      ),
    );
  }
}
