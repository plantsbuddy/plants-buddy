import 'package:flutter/material.dart';

import 'sample_appointment_item_gardener.dart';

class AppointmentsListGardener extends StatelessWidget {
  const AppointmentsListGardener({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 15),
      itemBuilder: (context, index) => SampleAppointmentItemGardener(),
      itemCount: 5,
    );
  }
}
