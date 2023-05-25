import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plants_buddy/features/reminders/domain/entities/reminder.dart';
import 'package:plants_buddy/features/reminders/domain/repositories/reminders_repository.dart';
import 'package:plants_buddy/features/reminders/logic/add_reminder_bloc/add_reminder_bloc.dart';

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
    await _myRemindersCollection.doc(reminder.id).set({
      'title': reminder.title,
      'description': reminder.description,
      'time': reminder.time.millisecondsSinceEpoch.toInt(),
      'repetition_period': reminder.repetitionPeriod.index,
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
      'description': reminder.description,
      'time': reminder.time.millisecondsSinceEpoch.toInt(),
      'repetition_period': reminder.repetitionPeriod.index,
    });
  }

  Reminder _createReminderFromDocument(QueryDocumentSnapshot<Object?> reminderDocument) {
    final reminderId = reminderDocument.id;
    final title = reminderDocument.get('title') as String;
    final description = reminderDocument.get('description') as String;
    final time = reminderDocument.get('time') as int;
    final repetitionPeriod = reminderDocument.get('repetition_period') as int;

    return Reminder(
      id: reminderId,
      title: title,
      description: description,
      repetitionPeriod: ReminderPeriod.values[repetitionPeriod],
      time: DateTime.fromMillisecondsSinceEpoch(time),
    );
  }
}
