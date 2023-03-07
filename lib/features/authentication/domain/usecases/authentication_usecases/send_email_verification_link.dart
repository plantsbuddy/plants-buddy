import 'package:plants_buddy/features/shared_preferences/domain/repositories/shared_preferences_repository.dart';

import '../../repositories/authentication_repository.dart';

class SendEmailVerificationLink {
  final AuthenticationRepository _authenticationRepository;
  SendEmailVerificationLink(this._authenticationRepository);

  Future<void> call() async {

    await _authenticationRepository.sendEmailVerificationLink();
    //await _sharedPreferencesRepository.putValue('username', name);

    //  await _authenticationService.updateUsername(name);
  }
}
