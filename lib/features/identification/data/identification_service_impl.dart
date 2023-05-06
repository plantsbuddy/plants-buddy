import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plants_buddy/features/identification/domain/entities/identification_history_item.dart';

import '../domain/entities/identification_result.dart';
import '../domain/repositories/identification_service.dart';
import '../logic/identification_bloc/identification_bloc.dart';

class IdentificationServiceImpl implements IdentificationService {
  final DocumentReference _userDocument;

  IdentificationServiceImpl()
      : _userDocument = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);

  @override
  Future<Map<String, dynamic>> getDiseaseDetails(String name) async {
    final details = await FirebaseFirestore.instance.collection('scraped_diseases').doc(name.trim()).get();
    return details.data()!;
  }

  @override
  Future<Map<String, dynamic>> getPestDetails(String name) async {
    final details = await FirebaseFirestore.instance.collection('scraped_pests').doc(name.trim()).get();
    return details.data()!;
  }

  @override
  Future<Map<String, dynamic>> getPlantDetails(String name) async {
    final details = await FirebaseFirestore.instance.collection('scraped_plants').doc(name.trim()).get();
    return details.data()!;
  }

  @override
  Future<void> saveIdentificationForHistory({
    required IdentificationType identificationType,
    required String imagePath,
    required List<IdentificationResult> results,
  }) async {
    var collection = '';
    var firstMatch = '';

    if (identificationType == IdentificationType.plant) {
      collection = 'identified_plants';
      firstMatch = results[0].data['scientific_name'];
    } else if (identificationType == IdentificationType.disease) {
      collection = 'identified_diseases';
      firstMatch = results[0].data['name'];
    } else {
      collection = 'identified_pests';
      firstMatch = results[0].data['name'];
    }

    final doc = await _userDocument.collection(collection).add({
      'time': DateTime.now().millisecondsSinceEpoch,
      'first_match': firstMatch,
    });

    for (int i = 0; i < results.length; i++) {
      _userDocument.collection(collection).doc(doc.id).collection('data').doc(i.toString()).set({
        'confidence': results[i].confidence,
        'label': results[i].label,
        'data': jsonEncode(results[i].data),
      });
    }

    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child('identification_images').child(doc.id);

    await imageRef.putFile(File(imagePath));
    final imageUrl = await imageRef.getDownloadURL();

    _userDocument.collection(collection).doc(doc.id).update({'image': imageUrl});
  }

  @override
  Future<List<IdentificationHistoryItem>> getIdentificationHistory(IdentificationType identificationType) async {
    var collection = '';

    if (identificationType == IdentificationType.plant) {
      collection = 'identified_plants';
    } else if (identificationType == IdentificationType.disease) {
      collection = 'identified_diseases';
    } else {
      collection = 'identified_pests';
    }

    final List<IdentificationHistoryItem> historyItems = [];

    final historyIdentifications = await _userDocument.collection(collection).get();

    for (var historyIdentification in historyIdentifications.docs) {
      final List<IdentificationResult> results = [];

      final identificationResults =
          await _userDocument.collection(collection).doc(historyIdentification.id).collection('data').get();

      for (var identificationResult in identificationResults.docs) {
        final result = IdentificationResult(
          confidence: identificationResult['confidence'],
          label: identificationResult['label'],
          data: jsonDecode(identificationResult['data']),
        );

        results.add(result);
      }

      historyItems.add(IdentificationHistoryItem(
        firstMatch: historyIdentification['first_match'],
        time: historyIdentification['time'],
        imageUrl: historyIdentification['image'],
        results: results,
      ));
    }

    return historyItems;
  }
}
