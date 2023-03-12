import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plants_buddy/core/utils/custom_icons.dart' as custom_icons;
import 'package:plants_buddy/features/botanists/domain/entities/appointment.dart';

class NoAppointmentsGardener extends StatelessWidget {
  const NoAppointmentsGardener(this.status, {Key? key}) : super(key: key);

  final AppointmentStatus status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            custom_icons.noAppointments,
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              _title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              _subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  String get _title {
    switch (status) {
      case AppointmentStatus.pending:
        return 'Appointment Requests';
      case AppointmentStatus.scheduled:
        return 'Pending Appointments';
      case AppointmentStatus.completed:
        return 'Completed Appointments';
      case AppointmentStatus.cancelled:
        return '';
      case AppointmentStatus.rejected:
        return '';
    }
  }

  String get _subtitle {
    switch (status) {
      case AppointmentStatus.pending:
        return 'You haven\'t sent any appointment request to a botanist';
      case AppointmentStatus.scheduled:
        return 'You don\'t have any pending appointments with a botanist';
      case AppointmentStatus.completed:
        return 'You haven\'t performed any appointment session with a botanist';
      case AppointmentStatus.cancelled:
        return '';
      case AppointmentStatus.rejected:
        return '';
    }
  }
}
