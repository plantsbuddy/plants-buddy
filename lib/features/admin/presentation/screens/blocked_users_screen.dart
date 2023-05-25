import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/admin_bloc.dart';
import '../components/no_reports.dart';
import '../components/sample_blocked_user.dart';

class BlockedUsersScreen extends StatelessWidget {
  const BlockedUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blocked Users'),
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        buildWhen: (previous, current) =>
            (previous.blockedUsers.length != current.blockedUsers.length) ||
            previous.blockedUsersStatus != current.blockedUsersStatus,
        builder: (context, state) {
          if (state.blockedUsersStatus == AdminDataStatus.loading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return state.blockedUsers.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) => SampleBlockedUser(state.blockedUsers[index]),
                    itemCount: state.blockedUsers.length,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  )
                : NoReports(
                    title: 'No Blocked Users',
                    subtitle: 'No users have been blocked yet. Once blocked, they will appear here.',
                  );
          }
        },
      ),
    );
  }
}
