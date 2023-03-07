import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plants_buddy/core/errors/exceptions.dart';

import '../domain/repositories/authentication_repository.dart';

class AuthenticationDataSource implements AuthenticationRepository {
  final FirebaseAuth _auth;

  AuthenticationDataSource() : _auth = FirebaseAuth.instance;

  Future<void> signupUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.sendEmailVerification();

      final userRef = FirebaseFirestore.instance.collection('users').doc(credential.user!.uid);

      await userRef.set({
        'name': name,
        'email': email,
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

  Future<void> loginUser({required String email, required String password}) async {
    await _auth.signOut();
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!_auth.currentUser!.emailVerified) {
        await _auth.currentUser!.sendEmailVerification();
        throw EmailNotVerifiedException();
      }
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
  }

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

  Future<void> sendEmailVerificationLink() async {
    await _auth.currentUser!.sendEmailVerification();
  }

  Future<void> updateUsername(String name) async {
    _auth.currentUser!.updateDisplayName(name);
  }

  Future<void> updateProfilePicture(String picturePath) async {
    //todo: first upload the image to storage by calling the firebase storage service and then pass link to the method below
    _auth.currentUser!.updatePhotoURL('');
  }
}
