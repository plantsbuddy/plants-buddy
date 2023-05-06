import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plants_buddy/features/collections/domain/entities/collection.dart';
import 'package:plants_buddy/features/collections/domain/repositories/collections_service.dart';

import '../domain/entities/collection_plant.dart';

class CollectionsServiceImpl implements CollectionsService {
  final CollectionReference _collectionsRef;
  final StreamController<List<Collection>> _collectionsController = StreamController<List<Collection>>.broadcast();
  final StreamController<List<CollectionPlant>> _collectionPlantsController =
      StreamController<List<CollectionPlant>>.broadcast();

  CollectionsServiceImpl()
      : _collectionsRef = FirebaseFirestore.instance
            .collection('collections')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('collections');

  @override
  Future<Stream<List<Collection>>> get collectionsStream async {
    _collectionsRef.snapshots().listen((collectionsSnapshots) async {
      final List<Collection> collections = [];

      for (var collectionMap in collectionsSnapshots.docs) {
        // final plantsSnapshots = await _collectionsRef.doc(collectionMap.id).collection('plants').get();
        //
        // final List<Map<String, dynamic>> plants = [];
        //
        // for (var plantMap in plantsSnapshots.docs) {
        //   plants.add(plantMap.data());
        // }

        final collection = Collection(
          id: collectionMap.id,
          cover: collectionMap['cover'],
          name: collectionMap['name'],
          //plants: plants,
        );

        collections.add(collection);
      }

      _collectionsController.add(collections);
    });

    return _collectionsController.stream.asBroadcastStream();
  }

  @override
  Future<Stream<List<CollectionPlant>>> getCollectionPlantsStream(Collection collection) async {
    _collectionsRef.doc(collection.id).collection('plants').snapshots().listen((collectionPlantsSnapshots) {
      final List<CollectionPlant> plants = [];

      for (var collectionPlantMap in collectionPlantsSnapshots.docs) {
        final plant = CollectionPlant(id: collectionPlantMap.id, details: collectionPlantMap.data());
        plants.add(plant);
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

    if (await File(collection.cover).exists()) {
      final storageRef = FirebaseStorage.instance.ref();

      final imageRef = storageRef.child('collection_covers').child(collection.id!);

      await imageRef.putFile(File(collection.cover));
      final imageUrl = await imageRef.getDownloadURL();

      _collectionsRef.doc(collection.id).update({'cover': imageUrl});
    }
  }

  @override
  Future<void> deleteCollection(Collection collection) async {
    await _collectionsRef.doc(collection.id).delete();
  }

  @override
  Future<void> deletePlantFromCollection({required CollectionPlant plant, required Collection collection}) async {
    await _collectionsRef.doc(collection.id).collection('plants').doc(plant.id).delete();
  }

  @override
  Future<void> updatePlantInCollection({required Collection collection, required CollectionPlant plant}) async {
    final collectionPlantsRef = _collectionsRef.doc(collection.id).collection('plants');

    if (plant.id == null) {
      final doc = await collectionPlantsRef.add(plant.details);
      plant = plant.copyWith(id: doc.id);
    } else {
      await collectionPlantsRef.doc(plant.id).update(plant.details);
    }

    if (await File(plant.details['images'][0]).exists()) {
      final storageRef = FirebaseStorage.instance.ref();

      final imageRef = storageRef.child('collection_plant_pictures').child(plant.id!);

      await imageRef.putFile(File(plant.details['images'][0]));
      final imageUrl = await imageRef.getDownloadURL();

      collectionPlantsRef.doc(plant.id).update({
        'images': [imageUrl]
      });
    }
  }
}
