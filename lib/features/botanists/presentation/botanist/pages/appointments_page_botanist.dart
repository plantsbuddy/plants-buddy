import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

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
            overlayColor:MaterialStateProperty.all<Color>(Colors.transparent),
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
          Expanded(
            child: TabBarView(
              children: [
                AppointmentsListBotanist(),
                AppointmentsListBotanist(),
                AppointmentsListBotanist(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
