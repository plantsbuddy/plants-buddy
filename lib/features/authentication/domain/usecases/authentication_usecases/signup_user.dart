import 'package:plants_buddy/core/errors/exceptions.dart';
import 'package:plants_buddy/features/shared_preferences/domain/repositories/shared_preferences_repository.dart';

import '../../repositories/authentication_repository.dart';

class SignupUser {
  final AuthenticationRepository _authenticationRepository;

  SignupUser(this._authenticationRepository);

  Future<void> call({
    required String name,
    required String email,
    required String password,
  }) async {
    if (name.trim().isEmpty) {
      throw EmptyNameException();
    }

    if (email.trim().isEmpty) {
      throw EmptyEmailException();
    }

    if (password.trim().isEmpty) {
      throw EmptyPasswordException();
    }

    if (password.trim().length < 8 || !password.contains(RegExp(r'[0-9]')) || !password.contains(RegExp(r'[A-z]')) || !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      throw WeakPasswordException();
    }

    await _authenticationRepository.signupUser(name: name.trim(), email: email.trim(), password: password.trim());
    //await _authenticationService.sendEmailLink(email);
  }
}
