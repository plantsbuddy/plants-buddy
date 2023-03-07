import 'package:plants_buddy/core/errors/exceptions.dart';

import '../../repositories/authentication_repository.dart';

class SendPasswordResetLink {
  final AuthenticationRepository _authenticationRepository;

  SendPasswordResetLink(this._authenticationRepository);

  Future<void> call(String email) async {
    if (email.trim().isEmpty) {
      throw EmptyEmailException();
    }

    await _authenticationRepository.sendPasswordResetLink(email.trim());
  }
}
