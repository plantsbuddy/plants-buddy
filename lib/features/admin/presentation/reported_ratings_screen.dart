import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/admin_bloc.dart';
import 'sample_reported_rating.dart';

class ReportedRatingsScreen extends StatelessWidget {
  const ReportedRatingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reported Ratings'),
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (false) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => SampleReportedRating(),
              itemCount: 1,
              padding: EdgeInsets.symmetric(horizontal: 20),
            );
          }
        },
      ),
    );
  }
}
