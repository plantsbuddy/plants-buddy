import 'package:plants_buddy/core/errors/exceptions.dart';

import '../../entities/user.dart';
import '../../repositories/authentication_repository.dart';

class LogoutUser {
  final AuthenticationRepository _authenticationRepository;

  LogoutUser(this._authenticationRepository);

  Future<void > call() async {
    return _authenticationRepository.logoutUser();
  }
}
