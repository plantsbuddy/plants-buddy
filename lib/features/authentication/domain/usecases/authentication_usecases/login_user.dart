import 'package:plants_buddy/core/errors/exceptions.dart';

import '../../repositories/authentication_repository.dart';

class LoginUser {
  final AuthenticationRepository _authenticationRepository;

  LoginUser(this._authenticationRepository);

  Future<void> call({required String email, required String password}) async {
    if (email.trim().isEmpty) {
      throw EmptyEmailException();
    }

    if (password.trim().isEmpty) {
      throw EmptyPasswordException();
    }

    await _authenticationRepository.loginUser(email: email.trim(), password: password.trim());
  }
}
