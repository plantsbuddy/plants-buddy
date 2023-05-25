import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:plants_buddy/features/reminders/domain/repositories/reminders_repository.dart';

class DeleteReminder {
  final RemindersRepository _remindersRepository;

  DeleteReminder(this._remindersRepository);

  Future<void> call(String reminderId) async {
    await _remindersRepository.deleteReminder(reminderId);

    await FlutterLocalNotificationsPlugin().cancel(int.parse(reminderId));
  }
}
