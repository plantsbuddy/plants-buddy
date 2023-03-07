part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthenticationInitializeEmailLinkListener extends AuthenticationEvent {}

class AuthenticationSignupPressed extends AuthenticationEvent {
  final String name, email, password;

  AuthenticationSignupPressed({required this.name, required this.email, required this.password});
}

class AuthenticationLoginPressed extends AuthenticationEvent {
  final String email, password;

  AuthenticationLoginPressed({required this.email, required this.password});
}

class AuthenticationSendVerificationLinkPressed extends AuthenticationEvent {}

class AuthenticationOpenEmailAppPressed extends AuthenticationEvent {}

class AuthenticationResendLinkPressed extends AuthenticationEvent {}

class AuthenticationPasswordVisibilityToggled extends AuthenticationEvent {}

class AuthenticationUpdateUsername extends AuthenticationEvent {
  final String username;

  AuthenticationUpdateUsername(this.username);
}

class AuthenticationUpdateProfilePicture extends AuthenticationEvent {
  final String profilePicturePath;

  AuthenticationUpdateProfilePicture(this.profilePicturePath);
}

class AuthenticationChangePagePressed extends AuthenticationEvent {
  final int? index;

  AuthenticationChangePagePressed({this.index});
}

class AuthenticationSendPasswordResetLinkPressed extends AuthenticationEvent {
  final String email;

  AuthenticationSendPasswordResetLinkPressed(this.email);
}
