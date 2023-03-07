import 'package:plants_buddy/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:plants_buddy/features/shared_preferences/domain/repositories/shared_preferences_repository.dart';

class UpdateUsername {
  final AuthenticationRepository _authenticationRepository;

  UpdateUsername(this._authenticationRepository);

  Future<void> call(String name) async {
    if (name.trim().isEmpty) return;

    //await _sharedPreferencesRepository.putValue('username', name);

    //  await _authenticationService.updateUsername(name);
  }
}
