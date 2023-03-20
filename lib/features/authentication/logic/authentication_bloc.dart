import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:plants_buddy/core/errors/exceptions.dart';

import '../domain/entities/gardener.dart';
import '../domain/entities/user.dart';
import '../domain/usecases/authentication_usecases.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUser _loginUser;
  final InitUser _initUser;
  final LogoutUser _logoutUser;

  final UpdateProfile _updateProfile;
  final SignupGardener _signupGardener;
  final SignupBotanist _signupBotanist;
  final SendPasswordResetLink _sendPasswordResetLink;
  final SendEmailVerificationLink _sendEmailVerificationLink;

  AuthenticationBloc(
    this._initUser,
    this._loginUser,
    this._updateProfile,
    this._signupGardener,
    this._signupBotanist,
    this._sendEmailVerificationLink,
    this._sendPasswordResetLink,
    this._logoutUser,
  ) : super(AuthenticationState.initial()) {
    on<AuthenticationInitUser>(onAuthenticationInitUser);
    on<AuthenticationSignupGardenerPressed>(onAuthenticationSignupGardenerPressed);
    on<AuthenticationSignupBotanistPressed>(onAuthenticationSignupBotanistPressed);
    on<AuthenticationLoginPressed>(onAuthenticationLoginPressed);
    on<AuthenticationOpenEmailAppPressed>(onAuthenticationOpenEmailAppPressed);
    on<AuthenticationSendPasswordResetLinkPressed>(onAuthenticationSendPasswordResetLinkPressed);
    on<AuthenticationChangePagePressed>(onAuthenticationChangePagePressed);
    on<AuthenticationSendVerificationLinkPressed>(onAuthenticationSendVerificationLinkPressed);
    on<AuthenticationPasswordVisibilityToggled>(onAuthenticationPasswordVisibilityToggled);
    on<AuthenticationUpdateProfile>(onAuthenticationUpdateProfile);
    on<AuthenticationLogoutPressed>(onAuthenticationLogoutPressed);
  }

  Future<FutureOr<void>> onAuthenticationInitUser(
      AuthenticationInitUser event, Emitter<AuthenticationState> emit) async {
    final user = await _initUser();
    emit(state.copyWith(userLoggedIn: true, currentUser: () => user));
  }

  Future<FutureOr<void>> onAuthenticationSignupGardenerPressed(
      AuthenticationSignupGardenerPressed event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
      signupNameError: () => null,
      signupEmailError: () => null,
      signupPasswordError: () => null,
      dialogText: () => 'Signing up...',
      dialogShowing: true,
    ));

    try {
      await _signupGardener(name: event.name, email: event.email, password: event.password);

      emit(state.copyWith(pageIndex: 2));
    } on EmptyNameException {
      emit(state.copyWith(signupNameError: () => 'Please fill this field'));
    } on EmptyEmailException {
      emit(state.copyWith(signupEmailError: () => 'Please fill this field'));
    } on EmptyPasswordException {
      emit(state.copyWith(signupPasswordError: () => 'Please fill this field'));
    } on EmailAlreadyInUseException {
      emit(state.copyWith(signupEmailError: () => 'Email already in use'));
    } on InvalidEmailException {
      emit(state.copyWith(signupEmailError: () => 'Invalid email address'));
    } on WeakPasswordException {
      emit(state.copyWith(signupPasswordError: () => 'Enter a strong password'));
    }

    emit(state.copyWith(dialogShowing: false));
  }

  Future<FutureOr<void>> onAuthenticationSignupBotanistPressed(
      AuthenticationSignupBotanistPressed event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
      signupNameError: () => null,
      signupEmailError: () => null,
      signupPasswordError: () => null,
      signupConsultationChargesError: () => null,
      signupDescriptionError: () => null,
      signupQualificationError: () => null,
      signupPhoneNumberError: () => null,
      signupSpecialtyError: () => null,
      dialogText: () => 'Signing up...',
      dialogShowing: true,
    ));
    try {
      await _signupBotanist(
        name: event.name,
        email: event.email,
        password: event.password,
        specialty: event.specialty,
        qualification: event.qualification,
        phoneNumber: event.phoneNumber,
        description: event.description,
        consultationCharges: event.consultationCharges,
        city: event.city,
      );

      emit(state.copyWith(pageIndex: 2));
    } on EmptyNameException {
      emit(state.copyWith(signupNameError: () => 'Please fill this field'));
    } on EmptyEmailException {
      emit(state.copyWith(signupEmailError: () => 'Please fill this field'));
    } on EmptyPasswordException {
      emit(state.copyWith(signupPasswordError: () => 'Please fill this field'));
    } on EmailAlreadyInUseException {
      emit(state.copyWith(signupEmailError: () => 'Email already in use'));
    } on InvalidEmailException {
      emit(state.copyWith(signupEmailError: () => 'Invalid email address'));
    } on EmptyConsultationChargesException {
      emit(state.copyWith(signupConsultationChargesError: () => 'Please fill this field'));
    } on EmptyCityException {
      emit(state.copyWith(signupCityError: () => 'Please fill this field'));
    } on EmptyDescriptionException {
      emit(state.copyWith(signupDescriptionError: () => 'Please fill this field'));
    } on EmptyQualificationException {
      emit(state.copyWith(signupQualificationError: () => 'Please fill this field'));
    } on EmptyPhoneNumberException {
      emit(state.copyWith(signupPhoneNumberError: () => 'Please fill this field'));
    } on EmptySpecialtyException {
      emit(state.copyWith(signupSpecialtyError: () => 'Please fill this field'));
    } on WeakPasswordException {
      emit(state.copyWith(signupPasswordError: () => 'Enter a strong password'));
    }

    emit(state.copyWith(dialogShowing: false));
  }

  Future<FutureOr<void>> onAuthenticationLoginPressed(
      AuthenticationLoginPressed event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
      loginEmailError: () => null,
      loginPasswordError: () => null,
      dialogText: () => 'Logging in...',
      dialogShowing: true,
    ));

    try {
      // print(FirebaseAuth.instance.currentUser == null ? 'Null before' : 'Not null before');
      final currentUser = await _loginUser(email: event.email, password: event.password);

      emit(state.copyWith(userLoggedIn: true, currentUser: () => currentUser));
    } on EmptyEmailException {
      emit(state.copyWith(loginEmailError: () => 'Please fill this field'));
    } on EmptyPasswordException {
      emit(state.copyWith(loginPasswordError: () => 'Please fill this field'));
    } on UserNotFoundException {
      emit(state.copyWith(loginEmailError: () => 'Email not registered'));
    } on EmailNotVerifiedException {
      emit(state.copyWith(pageIndex: 3));
    } on InvalidEmailException {
      emit(state.copyWith(loginEmailError: () => 'Invalid email address'));
    } on WrongPasswordException {
      emit(state.copyWith(loginPasswordError: () => 'Invalid password'));
    } on TooManyLoginAttemptsException {
      emit(state.copyWith(loginPasswordError: () => 'Too many login attempts, try again later!'));
    }

    emit(state.copyWith(dialogShowing: false));
  }

  Future<FutureOr<void>> onAuthenticationSendPasswordResetLinkPressed(
      AuthenticationSendPasswordResetLinkPressed event, Emitter<AuthenticationState> emit) async {
    emit(
      state.copyWith(
        resetEmailError: () => null,
        dialogText: () => 'Sending password reset email...',
        dialogShowing: true,
      ),
    );

    try {
      await _sendPasswordResetLink(event.email);

      emit(state.copyWith(pageIndex: 5));
    } on EmptyEmailException {
      emit(state.copyWith(resetEmailError: () => 'Please fill this field'));
    } on UserNotFoundException {
      emit(state.copyWith(resetEmailError: () => 'Email not registered in system'));
    } on InvalidEmailException {
      emit(state.copyWith(resetEmailError: () => 'Invalid email address'));
    }

    emit(state.copyWith(dialogShowing: false));
  }

  Future<FutureOr<void>> onAuthenticationOpenEmailAppPressed(_, __) async {
    await OpenMailApp.openMailApp();
  }

  FutureOr<void> onAuthenticationChangePagePressed(
      AuthenticationChangePagePressed event, Emitter<AuthenticationState> emit) {
    int newIndex = event.index ?? _determineBackPage(state.pageIndex);
    emit(state.copyWith(pageIndex: newIndex));
  }

  Future<FutureOr<void>> onAuthenticationSendVerificationLinkPressed(_, Emitter<AuthenticationState> emit) async {
    await _sendEmailVerificationLink();
  }

  FutureOr<void> onAuthenticationPasswordVisibilityToggled(
      AuthenticationPasswordVisibilityToggled event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }

  int _determineBackPage(int pageIndex) {
    switch (pageIndex) {
      case 1:
        return 0;
      case 2:
        return 1;
      case 3:
        return 0;
      case 4:
        return 0;
      case 5:
        return 4;
      default:
        return 1;
    }
  }

  Future<FutureOr<void>> onAuthenticationUpdateProfile(
      AuthenticationUpdateProfile event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(dialogShowing: true));

    final pictureUrl = await _updateProfile(
      picDeleted: event.picDeleted,
      name: event.name,
      selectedImagePath: event.profilePicturePath,
    );

    emit(state.copyWith(
      dialogShowing: false,
      currentUser: () => state.currentUser!.copy(username: event.name, profilePicture: pictureUrl),
    ));
  }

  Future<FutureOr<void>> onAuthenticationLogoutPressed(
      AuthenticationLogoutPressed event, Emitter<AuthenticationState> emit) async {
    await _logoutUser();
    emit(state.copyWith(currentUser: () => null));
  }
}
