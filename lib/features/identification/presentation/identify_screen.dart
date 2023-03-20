import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/identification/presentation/pages/page_identify.dart';

import '../logic/identification_bloc.dart';
import 'pages/page_identification_results.dart';

class IdentifyScreen extends StatelessWidget {
  IdentifyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.select((IdentificationBloc bloc) => bloc.state.status);

    switch (status) {
      case IdentificationStatus.initial:
        return PageIdentify();
      case IdentificationStatus.loading:
        return Placeholder();
      case IdentificationStatus.identificationPerformed:
        return PageIdentificationResults();
      case IdentificationStatus.dataLoaded:
        return Placeholder();
    }
  }
}
