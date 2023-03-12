part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthenticationInitUser extends AuthenticationEvent {}

class AuthenticationInitializeEmailLinkListener extends AuthenticationEvent {}

class AuthenticationSignupGardenerPressed extends AuthenticationEvent {
  final String name, email, password;

  AuthenticationSignupGardenerPressed({
    required this.name,
    required this.email,
    required this.password,
  });
}

class AuthenticationSignupBotanistPressed extends AuthenticationEvent {
  final String name, email, password, city, consultationCharges, specialty, description, qualification, phoneNumber;

  AuthenticationSignupBotanistPressed({
    required this.name,
    required this.email,
    required this.password,
    required this.consultationCharges,
    required this.city,
    required this.specialty,
    required this.description,
    required this.qualification,
    required this.phoneNumber,
  });
}

class AuthenticationLoginPressed extends AuthenticationEvent {
  final String email, password;

  AuthenticationLoginPressed({required this.email, required this.password});
}

class AuthenticationSendVerificationLinkPressed extends AuthenticationEvent {}

class AuthenticationOpenEmailAppPressed extends AuthenticationEvent {}

class AuthenticationResendLinkPressed extends AuthenticationEvent {}

class AuthenticationPasswordVisibilityToggled extends AuthenticationEvent {}

class AuthenticationUpdateProfile extends AuthenticationEvent {
  final String? profilePicturePath;
  final String name;
  final bool picDeleted;

  AuthenticationUpdateProfile({
    required this.name,
    required this.profilePicturePath,
    required this.picDeleted,
  });
}

class AuthenticationChangePagePressed extends AuthenticationEvent {
  final int? index;

  AuthenticationChangePagePressed({this.index});
}

class AuthenticationSendPasswordResetLinkPressed extends AuthenticationEvent {
  final String email;

  AuthenticationSendPasswordResetLinkPressed(this.email);
}
