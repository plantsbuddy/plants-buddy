import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:plants_buddy/features/authentication/domain/entities/botanist.dart';

import 'package:plants_buddy/features/botanists/domain/entities/appointment.dart';

import 'package:plants_buddy/features/botanists/domain/entities/botanist_review.dart';

import '../../authentication/domain/entities/user.dart';
import '../../community/domain/entities/user.dart' as community_user;
import '../domain/entities/appointment_slot.dart';
import '../domain/repositories/appointment_service.dart';

class AppointmentServiceImpl implements AppointmentService {
  final CollectionReference _appointmentsRef;
  final CollectionReference _usersRef;

  final _reviewsStreamController = StreamController<List<BotanistReview>>.broadcast();
  final _sentAppointmentRequestsController = StreamController<List<Appointment>>.broadcast();
  final _receivedAppointmentRequestsController = StreamController<List<Appointment>>.broadcast();

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
  Future<List<int>> getPendingAppointmentsOfBotanist(Botanist botanist) async {
    final details = await _usersRef.doc(botanist.uid).get();

    return List<int>.from(details.get('pending_appointments'));
  }

  @override
  Future<void> sendAppointmentRequest(Appointment appointment) async {
    await _appointmentsRef.add({
      'gardener': appointment.gardener.uid,
      'botanist': appointment.botanist.uid,
      'notes': appointment.notes,
      'time': appointment.slot.startingTime,
      //'date': appointment.date,
      'status': 0,
    });

    final details = await _usersRef.doc(appointment.botanist.uid).get();

    final updatedPendingAppointments = List<int>.from(details.get('pending_appointments'))
      ..add(appointment.slot.startingTime);

    await _usersRef.doc(appointment.botanist.uid).update({'pending_appointments': updatedPendingAppointments});
  }

  @override
  Future<void> cancelAppointmentRequest(Appointment appointment) async {
    final appointmentRef = _appointmentsRef.doc(appointment.id);
    //
    // final appointmentMap = await appointmentRef.get();
    //
    // final status = appointmentMap.get('status') as int;

    await appointmentRef.update({'status': 3});

    final details = await _usersRef.doc(appointment.botanist.uid).get();

    final updatedPendingAppointments = List<int>.from(details.get('pending_appointments'))
      ..remove(appointment.slot.startingTime);

    await _usersRef.doc(appointment.botanist.uid).update({'pending_appointments': updatedPendingAppointments});
  }

  @override
  Future<void> approveAppointmentRequest(Appointment appointment) async {
    await _appointmentsRef.doc(appointment.id).update({'status': 1});
  }

  @override
  Future<void> rejectAppointmentRequest(Appointment appointment) async {
    await _appointmentsRef.doc(appointment.id).update({'status': 4});

    final details = await _usersRef.doc(appointment.botanist.uid).get();

    final updatedPendingAppointments = List<int>.from(details.get('pending_appointments'))
      ..remove(appointment.slot.startingTime);

    await _usersRef.doc(appointment.botanist.uid).update({'pending_appointments': updatedPendingAppointments});
  }

  @override
  Future<Stream<List<BotanistReview>>> getBotanistReviews(Botanist botanist) async {
    _usersRef.doc(botanist.uid as String).collection('reviews').snapshots().listen((reviewsSnapshots) async {
      final List<BotanistReview> reviews = [];

      for (var reviewMap in reviewsSnapshots.docs) {
        final userDetailsRef = await _usersRef.doc(reviewMap.get('author')).get();

        final author = community_user.User(
          uid: userDetailsRef.id,
          name: userDetailsRef.get('name') as String,
          pictureUrl: userDetailsRef.get('pictureUrl'),
        );

        final review = BotanistReview(
          id: reviewMap.id,
          author: author,
          review: reviewMap.get('review'),
          time: reviewMap.get('time'),
          stars: reviewMap.get('stars'),
        );

        reviews.add(review);
      }

      _reviewsStreamController.add(reviews);
    });

    return _reviewsStreamController.stream.asBroadcastStream();
  }

  @override
  Future<void> postBotanistReview({required String botanist, required BotanistReview botanistReview}) async {
    final authorUid = FirebaseAuth.instance.currentUser!.uid;

    await _usersRef.doc(botanist).collection('reviews').doc(authorUid).set({
      'author': authorUid,
      'review': botanistReview.review,
      'time': botanistReview.time,
      'stars': botanistReview.stars,
    });
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

    return _sentAppointmentRequestsController.stream.asBroadcastStream();
  }

  @override
  Future<Stream<List<Appointment>>> getReceivedAppointmentRequests() async {
    final currentBotanistUid = FirebaseAuth.instance.currentUser!.uid;

    _appointmentsRef
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

    return _receivedAppointmentRequestsController.stream.asBroadcastStream();
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
        slot: AppointmentSlot(appointmentRequestMap.get('time') as int),
        //date: appointmentRequestMap.get('date') as int,
        status: AppointmentStatus.values[appointmentRequestMap.get('status') as int],
        minutes: (appointmentRequestMap.data() as Map<String, dynamic>).keys.contains('minutes') ? appointmentRequestMap
            .get('minutes') : null,
    );
  }

  @override
  Future<void> deleteAppointmentRequest(Appointment appointment) async {
    final appointmentRef = _appointmentsRef.doc(appointment.id);
    await appointmentRef.delete();
  }

  @override
  Future<void> completeAppointment({required Appointment appointment, required String minutes}) async {
    await _appointmentsRef.doc(appointment.id).update({'status': 2, 'minutes': minutes});

    final details = await _usersRef.doc(appointment.botanist.uid).get();

    final updatedPendingAppointments = List<int>.from(details.get('pending_appointments'))
      ..remove(appointment.slot.startingTime);

    await _usersRef.doc(appointment.botanist.uid).update({'pending_appointments': updatedPendingAppointments});
  }

  @override
  Future<void> reportBotanist({required Botanist botanist, required String reportText}) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    final reportedBotanistsCollection = FirebaseFirestore.instance.collection('reported_botanists');

    await reportedBotanistsCollection.doc(botanist.uid).set({'id': botanist.uid});

    // If user has already reported, then only the report_text will be changed
    await reportedBotanistsCollection.doc(botanist.uid).collection('reporters').doc(currentUserId).set({
      'report_text': reportText,
      'time': DateTime
          .now()
          .millisecondsSinceEpoch,
    });
  }

  @override
  Future<void> reportBotanistReview(
      {required Botanist botanist, required BotanistReview review, required String reportText}) async {
    // review id is user id of the reviewer

    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    final reportedReviewsCollection = FirebaseFirestore.instance.collection('reported_botanist_reviews');

    final reportedReviewDocs = await reportedReviewsCollection
        .where('botanist_id', isEqualTo: botanist.uid)
        .where('reviewer_id', isEqualTo: review.id)
        .get();

    var reportedReviewDoc = reportedReviewDocs.size == 0
        ? await reportedReviewsCollection.add({
      'botanist_id': botanist.uid,
      'reviewer_id': review.id,
    })
        : reportedReviewDocs.docs.first.reference;

    // If user has already reported, then only the report_text will be changed
    await reportedReviewDoc.collection('reporters').doc(currentUserId).set({
      'report_text': reportText,
      'time': DateTime
          .now()
          .millisecondsSinceEpoch,
    });
  }
}
