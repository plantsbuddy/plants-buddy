import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/features/botanists/logic/gardener_appointment_bloc/gardener_appointment_bloc.dart';

import '../components/sample_botanist_item.dart';

class BotanistsPage extends StatelessWidget {
  const BotanistsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GardenerAppointmentBloc>().state;

    return ListView.builder(
      itemBuilder: (context, index) => SampleBotanistItem(state.botanists[index]),
      itemCount: state.botanists.length,
    );
  }
}
