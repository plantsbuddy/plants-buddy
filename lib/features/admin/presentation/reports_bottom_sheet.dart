import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/admin_bloc.dart';
import 'components/sample_report_item.dart';

class ReportsBottomSheet extends StatelessWidget {
  const ReportsBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(0, 0, 0, 0.001),
      child: GestureDetector(
        onTap: () {},
        child: DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.2,
          maxChildSize: 0.75,
          builder: (_, controller) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(25.0),
                  topRight: const Radius.circular(25.0),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Reports',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  BlocBuilder<AdminBloc, AdminState>(
                    buildWhen: (previous, current) =>
                        (previous.reportsStatus != current.reportsStatus) &&
                        (previous.reports.length != current.reports.length),
                    builder: (context, state) {
                      switch (state.reportsStatus) {
                        case AdminDataStatus.loading:
                          return Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );

                        case AdminDataStatus.loaded:
                          return Expanded(
                            child: ListView.builder(
                              controller: controller,
                              itemCount: state.reports.length,
                              itemBuilder: (_, index) => SampleReport(state.reports[index]),
                            ),
                          );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
