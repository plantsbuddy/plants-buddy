import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as app_routes;
import 'package:plants_buddy/features/identification/presentation/pages/page_identify.dart';

import '../logic/identification_bloc/identification_bloc.dart';
import 'identification_results_screen.dart';

class IdentifyScreen extends StatelessWidget {
  IdentifyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<IdentificationBloc, IdentificationState>(
      listener: (context, state) {
        if (state.status == IdentificationStatus.identifying) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                  child: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Identifying ${state.identificationType.toString().split('.')[1]}...'),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state.status == IdentificationStatus.dataLoaded) {
          Navigator.of(context).pop();
          Navigator.of(context)
              .pushNamed(app_routes.identificationResults, arguments: context.read<IdentificationBloc>());
        }
      },
      listenWhen: (previous, current) => previous.status != current.status,
      child: PageIdentify(),
    );
  }
}
