import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/identification/logic/identification_bloc.dart';

class PageIdentificationResults extends StatelessWidget {
  const PageIdentificationResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<IdentificationBloc>().state;

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
                  File(state.image!),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              ...state.identificationResults.map(
                (result) => GestureDetector(
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              (state.identificationResults.indexOf(result) + 1).toString(),
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
                                  result.label,
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
