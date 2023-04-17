import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/repositories/identification_service.dart';

class IdentificationServiceImpl implements IdentificationService {
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
}
