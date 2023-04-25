import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plants_buddy/features/collections/domain/entities/collection.dart';
import 'package:plants_buddy/features/collections/domain/repositories/collections_service.dart';

class CollectionsServiceImpl implements CollectionsService {
  final CollectionReference _collectionsRef;
  final StreamController<List<Collection>> _collectionsController = StreamController<List<Collection>>.broadcast();
  final StreamController<List<Map<String, dynamic>>> _collectionPlantsController =
      StreamController<List<Map<String, dynamic>>>.broadcast();

  CollectionsServiceImpl() : _collectionsRef = FirebaseFirestore.instance.collection('collections');

  @override
  Future<Stream<List<Collection>>> get collectionsStream async {
    _collectionsRef.snapshots().listen((collectionsSnapshots) async {
      final List<Collection> collections = [];

      for (var collectionMap in collectionsSnapshots.docs) {
        final plantsSnapshots = await _collectionsRef.doc(collectionMap.id).collection('plants').get();

        final List<Map<String, dynamic>> plants = [];

        for (var plantMap in plantsSnapshots.docs) {
          plants.add(plantMap.data());
        }

        final collection = Collection(
          id: collectionMap.id,
          cover: collectionMap['cover'],
          name: collectionMap['name'],
          plants: plants,
        );

        collections.add(collection);
      }

      _collectionsController.add(collections);
    });

    return _collectionsController.stream.asBroadcastStream();
  }

  @override
  Future<Stream<List<Map<String, dynamic>>>> getCollectionPlantsStream(Collection collection) async {
    _collectionsRef.doc(collection.id).collection('plants').snapshots().listen((collectionPlantsSnapshots) {
      final List<Map<String, dynamic>> plants = [];

      for (var collectionPlantMap in collectionPlantsSnapshots.docs) {
        plants.add(collectionPlantMap.data());
      }

      _collectionPlantsController.add(plants);
    });

    return _collectionPlantsController.stream.asBroadcastStream();
  }

  @override
  Future<void> updateCollection(Collection collection) async {
    if (collection.id == null) {
      final doc = await _collectionsRef.add({'name': collection.name});
      collection = collection.copyWith(id: doc.id);
    } else {
      await _collectionsRef.doc(collection.id).update({'name': collection.name});
    }

    final storageRef = FirebaseStorage.instance.ref();

    final imageRef = storageRef.child('collection_covers').child(collection.id!);

    await imageRef.putFile(File(collection.cover));
    final imageUrl = await imageRef.getDownloadURL();

    _collectionsRef.doc(collection.id).update({'cover': imageUrl});
  }

  @override
  Future<void> deleteCollection(Collection collection) async {
    await _collectionsRef.doc(collection.id).delete();
  }

  @override
  Future<void> addPlantToCollection({required Collection collection, required Map<String, dynamic> plant}) async {
    await _collectionsRef.doc(collection.id).collection('plants').add(plant);
  }
}
