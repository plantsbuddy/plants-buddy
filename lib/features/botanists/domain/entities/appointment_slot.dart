import 'package:equatable/equatable.dart';

class AppointmentSlot extends Equatable {
  final int startingTime;
  final String text;

  AppointmentSlot(this.startingTime)
      : text =
            '${DateTime.fromMillisecondsSinceEpoch(startingTime).hour}-${DateTime.fromMillisecondsSinceEpoch(startingTime).hour + 1}';

  @override
  List<Object?> get props => [startingTime, text];
}
