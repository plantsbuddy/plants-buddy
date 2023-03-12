import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:plants_buddy/features/authentication/domain/entities/botanist.dart';

import 'package:plants_buddy/features/botanists/domain/entities/appointment.dart';

import 'package:plants_buddy/features/botanists/domain/entities/botanist_review.dart';

import '../../authentication/domain/entities/user.dart';
import '../domain/repositories/appointment_service.dart';

class AppointmentServiceImpl implements AppointmentService {
  final CollectionReference _appointmentsRef;
  final CollectionReference _usersRef;

  final _reviewsStreamController = StreamController<List<BotanistReview>>();
  final _sentAppointmentRequestsController = StreamController<List<Appointment>>();
  final _receivedAppointmentRequestsController = StreamController<List<Appointment>>();

  AppointmentServiceImpl()
      : _appointmentsRef = FirebaseFirestore.instance.collection('appointments'),
        _usersRef = FirebaseFirestore.instance.collection('users');

  @override
  Future<List<Botanist>> getBotanists() async {
    final botanistsRef = await _usersRef.where('type', isEqualTo: 'botanist').get();

    final List<Botanist> botanists = [];

    for (var botanistMap in botanistsRef.docs) {
      final botanist = Botanist(
        uid: botanistMap.id,
        username: botanistMap.get('name'),
        email: botanistMap.get('email'),
        profilePicture: botanistMap.get('pictureUrl'),
        consultationCharges: botanistMap.get('consultation_charges'),
        specialty: botanistMap.get('specialty'),
        description: botanistMap.get('description'),
        qualification: botanistMap.get('qualification'),
        phoneNumber: botanistMap.get('phone_number'),
        city: botanistMap.get('city'),
      );

      botanists.add(botanist);
    }

    return botanists;
  }

  @override
  Future<void> sendAppointmentRequest(Appointment appointment) async {
    await _appointmentsRef.add({
      'gardener': appointment.gardener.uid,
      'botanist': appointment.botanist.uid,
      'notes': appointment.notes,
      'hour': appointment.hour,
      'minute': appointment.minute,
      'dayPeriod': appointment.dayPeriod,
      'date': appointment.date,
      'status': 0,
    });
  }

  @override
  Future<void> cancelAppointmentRequest(Appointment appointment) async {
    final appointmentRef = _appointmentsRef.doc(appointment.id);

    final appointmentMap = await appointmentRef.get();

    final status = appointmentMap.get('status') as int;

    if (status == 0) {
      await appointmentRef.update({'status': 3});
    } else {
      await appointmentRef.delete();
    }
  }

  @override
  Future<void> approveAppointmentRequest(Appointment appointment) async {
    await _appointmentsRef.doc(appointment.id).update({'status': 1});
  }

  @override
  Future<void> rejectAppointmentRequest(Appointment appointment) async {
    await _appointmentsRef.doc(appointment.id).delete();
  }

  @override
  Future<Stream<List<BotanistReview>>> getBotanistReviews(Botanist botanist) async {
    _usersRef.doc(botanist.uid as String).collection('reviews').snapshots().listen((reviewsSnapshots) {
      final List<BotanistReview> reviews = [];

      for (var reviewMap in reviewsSnapshots.docs) {
        final review = BotanistReview(
          author: reviewMap.get('author'),
          review: reviewMap.get('review'),
          time: reviewMap.get('time'),
          stars: reviewMap.get('stars'),
        );

        reviews.add(review);
      }

      _reviewsStreamController.add(reviews);
    });

    return _reviewsStreamController.stream;
  }

  @override
  Future<Stream<List<Appointment>>> getSentAppointmentRequestsStream() async {
    final currentUserUid = FirebaseAuth.instance.currentUser!.uid;

    _appointmentsRef.where('gardener', isEqualTo: currentUserUid).snapshots().listen((sentAppointmentsSnapshots) async {
      final List<Appointment> appointments = [];

      for (var appointmentMap in sentAppointmentsSnapshots.docs) {
        final appointment = await _createAppointmentObject(appointmentMap);

        appointments.add(appointment);
      }

      _sentAppointmentRequestsController.add(appointments);
    });

    return _sentAppointmentRequestsController.stream;
  }

  @override
  Future<Stream<List<Appointment>>> getReceivedAppointmentRequests() async {
    final currentBotanistUid = FirebaseAuth.instance.currentUser!.uid;

    _usersRef
        .where('botanist', isEqualTo: currentBotanistUid)
        .snapshots()
        .listen((receivedAppointmentsSnapshots) async {
      final List<Appointment> receivedAppointmentRequests = [];

      for (var appointmentRequestMap in receivedAppointmentsSnapshots.docs) {
        final appointmentRequest = await _createAppointmentObject(appointmentRequestMap);

        receivedAppointmentRequests.add(appointmentRequest);
      }

      _receivedAppointmentRequestsController.add(receivedAppointmentRequests);
    });

    return _receivedAppointmentRequestsController.stream;
  }

  @override
  Future<void> postBotanistReview({required String botanist, required BotanistReview botanistReview}) async {
    await _usersRef.doc(botanist).collection('reviews').add({
      'author': botanistReview.author,
      'review': botanistReview.review,
      'time': botanistReview.time,
      'stars': botanistReview.stars,
    });
  }

  Future<Appointment> _createAppointmentObject(QueryDocumentSnapshot<Object?> appointmentRequestMap) async {
    final gardenerDoc = await _usersRef.doc(appointmentRequestMap.get('gardener') as String).get();

    final gardener = User(
      uid: gardenerDoc.id,
      username: gardenerDoc.get('name') as String,
      email: gardenerDoc.get('email') as String,
      userType: UserType.gardener,
      profilePicture: gardenerDoc.get('pictureUrl') as String,
    );

    final botanistDoc = await _usersRef.doc(appointmentRequestMap.get('botanist') as String).get();

    final botanist = User(
      uid: botanistDoc.id,
      username: botanistDoc.get('name') as String,
      email: botanistDoc.get('email') as String,
      userType: UserType.botanist,
      profilePicture: botanistDoc.get('pictureUrl') as String,
    );

    return Appointment(
      id: appointmentRequestMap.id,
      gardener: gardener,
      botanist: botanist,
      notes: appointmentRequestMap.get('notes') as String,
      hour: appointmentRequestMap.get('hour') as int,
      minute: appointmentRequestMap.get('minute') as int,
      dayPeriod: appointmentRequestMap.get('dayPeriod') as int,
      date: appointmentRequestMap.get('date') as int,
      status: AppointmentStatus.values[appointmentRequestMap.get('status') as int],
    );
  }
}
