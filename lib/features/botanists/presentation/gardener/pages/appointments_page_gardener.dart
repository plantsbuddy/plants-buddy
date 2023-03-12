import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/botanists/domain/entities/appointment.dart';
import 'package:plants_buddy/features/botanists/logic/gardener_appointment_bloc/gardener_appointment_bloc.dart';

import '../components/appointments_list_gardener.dart';

class AppointmentsPageGardener extends StatelessWidget {
  const AppointmentsPageGardener({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
            tabs: [
              Tab(text: 'Requests'),
              Tab(text: 'Pending'),
              Tab(text: 'History'),
            ],
            padding: EdgeInsets.symmetric(horizontal: 10),
            unselectedLabelColor: Colors.black,
            labelColor: Theme.of(context).primaryColor,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BubbleTabIndicator(
              indicatorHeight: 35.0,
              indicatorColor: Theme.of(context).primaryColorLight.withOpacity(0.2),
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
          BlocBuilder<GardenerAppointmentBloc, GardenerAppointmentState>(
            buildWhen: (previous, current) => previous.sentAppointmentRequests != current.sentAppointmentRequests,
            builder: (context, state) {
              return Expanded(
                child: TabBarView(
                  children: [
                    AppointmentsListGardener(
                        appointments: state.pendingAppointments, appointmentsType: AppointmentStatus.pending),
                    AppointmentsListGardener(
                        appointments: state.scheduledAppointments, appointmentsType: AppointmentStatus.scheduled),
                    AppointmentsListGardener(
                        appointments: state.completedAppointments, appointmentsType: AppointmentStatus.completed),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
