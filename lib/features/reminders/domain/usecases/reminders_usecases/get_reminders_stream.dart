import 'package:plants_buddy/features/reminders/domain/repositories/reminders_repository.dart';

import '../../entities/reminder.dart';

class GetRemindersStream {
  final RemindersRepository _remindersRepository;

  GetRemindersStream(this._remindersRepository);

  Future<Stream<List<Reminder>>> call() async {
    return await _remindersRepository.getReminderStream();
  }
}
