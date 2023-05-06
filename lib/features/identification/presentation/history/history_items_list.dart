import 'package:flutter/material.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as app_routes;
import 'package:plants_buddy/features/identification/domain/entities/identification_history_item.dart';
import 'package:plants_buddy/features/identification/logic/identification_bloc/identification_bloc.dart';
import 'package:plants_buddy/features/identification/logic/identification_history_bloc/identification_history_bloc.dart';
import 'package:plants_buddy/features/identification/presentation/history/sample_identification_history_item.dart';

import 'no_history_items.dart';

class HistoryItemsList extends StatelessWidget {
  const HistoryItemsList({
    required this.historyItems,
    required this.status,
    required this.identificationType,
    Key? key,
  }) : super(key: key);

  final List<IdentificationHistoryItem> historyItems;
  final HistoryStatus status;
  final IdentificationType identificationType;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case HistoryStatus.loading:
        return Center(
          child: CircularProgressIndicator(),
        );

      case HistoryStatus.loaded:
        return historyItems.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15),
                itemBuilder: (context, index) => GestureDetector(
                  child: SampleIdentificationHistoryItem(historyItems[index]),
                  onTap: () {
                    Navigator.of(context).pushNamed(app_routes.historyIdentificationResults, arguments: {
                      'identification_type': identificationType,
                      'results': historyItems[index].results,
                    });
                  },
                ),
                itemCount: historyItems.length,
              )
            : NoHistoryItems(identificationType);
    }
  }
}
