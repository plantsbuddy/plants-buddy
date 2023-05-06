import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as app_routes;
import 'package:plants_buddy/features/identification/logic/identification_bloc/identification_bloc.dart';

import '../../domain/entities/identification_result.dart';

class HistoryIdentificationResultsScreen extends StatelessWidget {
  const HistoryIdentificationResultsScreen({Key? key, required this.identificationType, required this.results})
      : super(key: key);

  final IdentificationType identificationType;
  final List<IdentificationResult> results;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Identification Results'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(''),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              ...results.map(
                (result) => GestureDetector(
                  onTap: () {
                    switch (identificationType) {
                      case IdentificationType.plant:
                        Navigator.of(context)
                            .pushNamed(app_routes.plantDetails, arguments: result.data..['image'] = '');
                        break;
                      case IdentificationType.disease:
                        Navigator.of(context)
                            .pushNamed(app_routes.diseaseDetails, arguments: result.data..['image'] = '');
                        break;
                      case IdentificationType.pest:
                        Navigator.of(context)
                            .pushNamed(app_routes.plantDetails, arguments: result.data..['image'] = '');
                        break;
                    }
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              (results.indexOf(result) + 1).toString(),
                              style: TextStyle(color: Theme.of(context).hintColor, fontSize: 18),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 6.5, vertical: 1),
                            // decoration: BoxDecoration(
                            //     color: Theme.of(context).colorScheme.primaryContainer,
                            //     borderRadius: BorderRadius.circular(20)),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  result.data.keys.contains('scientific_name')
                                      ? result.data['scientific_name']
                                      : result.data['name'],
                                  style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.surfaceTint),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Confidence: ${result.confidence}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).hintColor,
                              size: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
