import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/admin_bloc.dart';
import '../components/no_reports.dart';
import '../components/sample_reported_rating.dart';

class ReportedRatingsScreen extends StatelessWidget {
  const ReportedRatingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reported Ratings'),
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        buildWhen: (previous, current) =>
            (previous.reportedRatings.length != current.reportedRatings.length) ||
            previous.reportedRatingsStatus != current.reportedRatingsStatus,
        builder: (context, state) {
          if (state.reportedRatingsStatus == AdminDataStatus.loading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return state.reportedRatings.isNotEmpty? ListView.builder(
              itemBuilder: (context, index) => SampleReportedRating(state.reportedRatings[index]),
              itemCount: state.reportedRatings.length,
              padding: EdgeInsets.symmetric(horizontal: 20),
            ): NoReports(
              title: 'No Reported Ratings',
              subtitle: 'No ratings on a botanist\'s profile have been reported yet. Once reported, they will appear here.',
            );
          }
        },
      ),
    );
  }
}
