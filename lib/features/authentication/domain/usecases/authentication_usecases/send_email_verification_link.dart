import '../../repositories/authentication_repository.dart';

class SendEmailVerificationLink {
  final AuthenticationRepository _authenticationRepository;

  SendEmailVerificationLink(this._authenticationRepository);

  Future<void> call() async {
    await _authenticationRepository.sendEmailVerificationLink();

    //  await _authenticationService.updateUsername(name);
  }
}
