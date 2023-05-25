import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/admin_bloc.dart';
import '../components/no_reports.dart';
import '../components/sample_reported_botanist.dart';

class ReportedBotanistsScreen extends StatelessWidget {
  const ReportedBotanistsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reported Botanists'),
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        buildWhen: (previous, current) =>
            (previous.reportedBotanists.length != current.reportedBotanists.length) ||
            previous.reportedBotanistsStatus != current.reportedBotanistsStatus,
        builder: (context, state) {
          if (state.reportedBotanistsStatus == AdminDataStatus.loading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return state.reportedBotanists.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) => SampleReportedBotanist(state.reportedBotanists[index]),
                    itemCount: state.reportedBotanists.length,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  )
                : NoReports(
                    title: 'No Reported Botanists',
                    subtitle: 'No botanists have been reported yet. Once reported, they will appear here.',
                  );
          }
        },
      ),
    );
  }
}
