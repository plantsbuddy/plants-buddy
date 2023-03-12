import 'package:plants_buddy/core/errors/exceptions.dart';
import 'package:plants_buddy/features/shared_preferences/domain/repositories/shared_preferences_repository.dart';

import '../../entities/gardener.dart';
import '../../repositories/authentication_repository.dart';

class SignupGardener {
  final AuthenticationRepository _authenticationRepository;

  SignupGardener(this._authenticationRepository);

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

    final gardener = Gardener(username: name.trim(), email: email.trim(), password: password.trim(), profilePicture: 'https://cdn-icons-png.flaticon.com/512/149/149071.png');

    await _authenticationRepository.signupGardener(gardener);
    //await _authenticationService.sendEmailLink(email);
  }
}
