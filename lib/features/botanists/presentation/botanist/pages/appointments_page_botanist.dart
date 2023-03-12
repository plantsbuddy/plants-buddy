import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/botanists/domain/entities/appointment.dart';
import 'package:plants_buddy/features/botanists/logic/botanist_appointment_bloc/botanist_appointment_bloc.dart';

import '../appointments_list_botanist.dart';

class AppointmentsPageBotanist extends StatefulWidget {
  const AppointmentsPageBotanist({Key? key}) : super(key: key);

  @override
  State<AppointmentsPageBotanist> createState() => _AppointmentsPageBotanistState();
}

class _AppointmentsPageBotanistState extends State<AppointmentsPageBotanist> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

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
          BlocBuilder<BotanistAppointmentBloc, BotanistAppointmentState>(
            buildWhen: (previous, current) => previous.receivedAppointments != current.receivedAppointments,
            builder: (context, state) {
              return Expanded(
                child: TabBarView(
                  children: [
                    AppointmentsListBotanist(
                      appointments: state.pendingAppointments,
                      appointmentsType: AppointmentStatus.pending,
                    ),
                    AppointmentsListBotanist(
                      appointments: state.scheduledAppointments,
                      appointmentsType: AppointmentStatus.scheduled,
                    ),
                    AppointmentsListBotanist(
                      appointments: state.completedAppointments,
                      appointmentsType: AppointmentStatus.completed,
                    ),
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
