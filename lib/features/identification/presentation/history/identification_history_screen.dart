import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/identification/logic/identification_bloc/identification_bloc.dart';

import '../../logic/identification_history_bloc/identification_history_bloc.dart';
import 'history_items_list.dart';

class IdentificationHistoryScreen extends StatelessWidget {
  const IdentificationHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Identification History'),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
              tabs: [
                Tab(text: 'Plants'),
                Tab(text: 'Diseases'),
                Tab(text: 'Pests'),
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
            BlocBuilder<IdentificationHistoryBloc, IdentificationHistoryState>(
              builder: (context, state) {
                return Expanded(
                  child: TabBarView(
                    children: [
                      HistoryItemsList(
                        status: state.plantsStatus,
                        historyItems: state.plants,
                        identificationType: IdentificationType.plant,
                      ),
                      HistoryItemsList(
                        status: state.diseasesStatus,
                        historyItems: state.diseases,
                        identificationType: IdentificationType.disease,
                      ),
                      HistoryItemsList(
                        status: state.pestsStatus,
                        historyItems: state.pests,
                        identificationType: IdentificationType.pest,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
