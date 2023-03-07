import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plants_buddy/features/reminders/domain/entities/reminder.dart';
import 'package:plants_buddy/features/reminders/domain/repositories/reminders_repository.dart';

class RemindersDataSource implements RemindersRepository {
  final CollectionReference _myRemindersCollection;
  final StreamController<List<Reminder>> _remindersController;

  RemindersDataSource()
      : _myRemindersCollection = FirebaseFirestore.instance
            .collection('all_reminders')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('my_reminders'),
        _remindersController = StreamController<List<Reminder>>();

  @override
  Future<void> addReminder(Reminder reminder) async {
    await _myRemindersCollection.add({
      'title': reminder.title,
      'hour': reminder.hour,
      'minute': reminder.minute,
      'dayPeriod': reminder.dayPeriod,
      'date': reminder.date,
    });
  }

  @override
  Future<void> deleteReminder(String reminderId) async {
    await _myRemindersCollection.doc(reminderId).delete();
  }

  @override
  Future<Stream<List<Reminder>>> getReminderStream() async {
    _myRemindersCollection.snapshots().listen(
      (documents) async {
        List<Reminder> reminders = [];

        for (var reminderDocument in documents.docs) {
          reminders.add(_createReminderFromDocument(reminderDocument));
        }

        _remindersController.add(reminders);
      },
    );

    return _remindersController.stream;
  }

  @override
  Future<void> updateReminder({required String reminderId, required Reminder reminder}) async {
    final reminderRef = _myRemindersCollection.doc(reminderId);
    await reminderRef.update({
      'title': reminder.title,
      'hour': reminder.hour,
      'minute': reminder.minute,
      'dayPeriod': reminder.dayPeriod,
      'date': reminder.date,
    });
  }

  Reminder _createReminderFromDocument(QueryDocumentSnapshot<Object?> reminderDocument) {
    final reminderId = reminderDocument.id;
    final title = reminderDocument.get('title') as String;
    final hour = reminderDocument.get('hour') as int;
    final minute = reminderDocument.get('minute') as int;
    final dayPeriod = reminderDocument.get('dayPeriod') as int;
    final date = reminderDocument.get('date') as int;

    return Reminder(
      id: reminderId,
      title: title,
      hour: hour,
      minute: minute,
      repetitionDays: [],
      dayPeriod: dayPeriod,
      date: date,
    );
  }
}
