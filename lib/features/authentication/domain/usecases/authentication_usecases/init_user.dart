import 'package:plants_buddy/core/errors/exceptions.dart';

import '../../entities/user.dart';
import '../../repositories/authentication_repository.dart';

class InitUser {
  final AuthenticationRepository _authenticationRepository;

  InitUser(this._authenticationRepository);

  Future<User> call() async {
    final user = await _authenticationRepository.user;
    return user!;
  }
}
