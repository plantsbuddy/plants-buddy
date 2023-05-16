import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plants_buddy/core/errors/exceptions.dart';
import 'package:plants_buddy/features/authentication/domain/entities/botanist.dart';
import 'package:plants_buddy/features/authentication/domain/entities/gardener.dart';

import '../domain/entities/user.dart';
import '../domain/repositories/authentication_repository.dart';

class AuthenticationDataSource implements AuthenticationRepository {
  final FirebaseAuth _auth;
  final CollectionReference _usersRef;

  AuthenticationDataSource()
      : _auth = FirebaseAuth.instance,
        _usersRef = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> signupGardener(Gardener gardener) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: gardener.email,
        password: gardener.password!,
      );

      await credential.user?.sendEmailVerification();

      final userRef = _usersRef.doc(credential.user!.uid);

      await userRef.set({
        'type': 'gardener',
        'name': gardener.username,
        'email': gardener.email,
        'blocked': false,
        'password': gardener.password,
        'pictureUrl': 'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/user-512.png',
      });

      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw EmailAlreadyInUseException();
        case 'invalid-email':
          throw InvalidEmailException();
        case 'weak-password':
          throw WeakPasswordException();
      }
    }
  }

  @override
  Future<void> signupBotanist(Botanist botanist) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: botanist.email,
        password: botanist.password!,
      );

      await credential.user?.sendEmailVerification();

      final userRef = _usersRef.doc(credential.user!.uid);

      await userRef.set({
        'type': 'botanist',
        'name': botanist.username,
        'email': botanist.email,
        'pictureUrl': 'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/user-512.png',
        'specialty': botanist.specialty,
        'qualification': botanist.qualification,
        'phone_number': botanist.phoneNumber,
        'city': botanist.city,
        'description': botanist.description,
        'consultation_charges': botanist.consultationCharges,
        'blocked': false,
      });

      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw EmailAlreadyInUseException();
        case 'invalid-email':
          throw InvalidEmailException();
        case 'weak-password':
          throw WeakPasswordException();
      }
    }
  }

  @override
  Future<User?> loginUser({required String email, required String password}) async {
    await _auth.signOut();
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!_auth.currentUser!.emailVerified) {
        await _auth.currentUser!.sendEmailVerification();
        await _auth.signOut();
        throw EmailNotVerifiedException();
      }

      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw InvalidEmailException();
        case 'user-not-found':
          throw UserNotFoundException();
        case 'wrong-password':
          throw WrongPasswordException();
        case 'too-many-requests':
          throw TooManyLoginAttemptsException();
      }
    }

    return null;
  }

  @override
  Future<void> sendPasswordResetLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw UserNotFoundException();
        case 'invalid-email':
          throw InvalidEmailException();
      }
    }
  }

  @override
  Future<User?> get user async {
    final user = await _usersRef.doc(_auth.currentUser!.uid).get();

    return User(
      uid: user.id,
      username: user.get('name'),
      email: user.get('email'),
      profilePicture: user.get('pictureUrl'),
      userType: user.get('type') == 'gardener' ? UserType.gardener : UserType.botanist,
    );

    // if (user.get('type') == 'gardener') {
    //   return Gardener(
    //     username: user.get('name'),
    //     email: user.get('email'),
    //     profilePicture: user.get('pictureUrl'),
    //   );
    // } else {
    //   return Botanist(
    //     username: user.get('name'),
    //     email: user.get('email'),
    //     profilePicture: user.get('pictureUrl'),
    //     consultationCharges: user.get('consultation_charges'),
    //     specialty: user.get('specialty'),
    //     description: user.get('description'),
    //     qualification: user.get('qualification'),
    //     phoneNumber: user.get('phone_number'),
    //     city: user.get('city'),
    //   );
    // }
  }

  @override
  Future<void> sendEmailVerificationLink() async {
    await _auth.currentUser!.sendEmailVerification();
  }

  @override
  Future<String> updateProfile({
    required String? selectedImagePath,
    required bool picDeleted,
    required String name,
  }) async {
    final userRef = _usersRef.doc(_auth.currentUser!.uid);
    if (!picDeleted && selectedImagePath != null) {
      final storageRef = FirebaseStorage.instance.ref();

      final imageRef = storageRef.child('profile_pictures').child(_auth.currentUser!.uid);

      await imageRef.putFile(File(selectedImagePath));
      final imageUrl = await imageRef.getDownloadURL();

      await userRef.update({'pictureUrl': imageUrl});
    } else if (picDeleted && selectedImagePath == null) {
      await userRef.update({'pictureUrl': 'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/user-512.png'});
    }

    await userRef.update({'name': name});

    final userDoc = await userRef.get();
    return userDoc.get('pictureUrl') as String;
  }

  @override
  Future<void> logoutUser() async {
    await _auth.signOut();
  }
}
