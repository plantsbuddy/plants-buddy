import '../entities/reminder.dart';

abstract class RemindersRepository {
  Future<void> addReminder(Reminder reminder);

  Future<Stream<List<Reminder>>> getReminderStream();

  Future<void> deleteReminder(String reminderId);

  Future<void> updateReminder({required String reminderId, required Reminder reminder});
}
