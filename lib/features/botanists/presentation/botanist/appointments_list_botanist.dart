import 'package:flutter/material.dart';

import 'components/sample_appointment_item_botanist.dart';

class AppointmentsListBotanist extends StatelessWidget {
  const AppointmentsListBotanist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 15),
      itemBuilder: (context, index) => SampleAppointmentItemBotanist(),
      itemCount: 5,
    );
  }
}
