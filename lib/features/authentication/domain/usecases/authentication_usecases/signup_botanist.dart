import 'package:plants_buddy/core/errors/exceptions.dart';

import '../../entities/botanist.dart';
import '../../repositories/authentication_repository.dart';

class SignupBotanist {
  final AuthenticationRepository _authenticationRepository;

  SignupBotanist(this._authenticationRepository);

  Future<void> call({
    required String name,
    required String email,
    required String password,
    required String consultationCharges,
    required String specialty,
    required String description,
    required String qualification,
    required String phoneNumber,
    required String city,
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

    if (consultationCharges.trim().isEmpty) {
      throw EmptyConsultationChargesException();
    }

    if (specialty.trim().isEmpty) {
      throw EmptySpecialtyException();
    }

    if (description.trim().isEmpty) {
      throw EmptyDescriptionException();
    }

    if (city.trim().isEmpty) {
      throw EmptyCityException();
    }

    if (qualification.trim().isEmpty) {
      throw EmptyQualificationException();
    }

    if (phoneNumber.trim().isEmpty) {
      throw EmptyPhoneNumberException();
    }

    if (password.trim().length < 8 ||
        !password.contains(RegExp(r'[0-9]')) ||
        !password.contains(RegExp(r'[A-z]')) ||
        !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      throw WeakPasswordException();
    }

    final botanist = Botanist(
      username: name.trim(),
      email: email.trim(),
      password: password.trim(),
      profilePicture: 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
      consultationCharges: double.parse(consultationCharges),
      description: description,
      phoneNumber: phoneNumber,
      qualification: qualification,
      specialty: specialty,
      city: city,
    );

    await _authenticationRepository.signupBotanist(botanist);
    //await _authenticationService.sendEmailLink(email);
  }
}
