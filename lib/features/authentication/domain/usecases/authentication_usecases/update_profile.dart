import 'package:plants_buddy/features/authentication/domain/repositories/authentication_repository.dart';

class UpdateProfile {
  final AuthenticationRepository _authenticationRepository;

  UpdateProfile(this._authenticationRepository);

  Future<String> call({
    required String? selectedImagePath,
    required bool picDeleted,
    required String name,
  }) async {
    return _authenticationRepository.updateProfile(
        selectedImagePath: selectedImagePath, picDeleted: picDeleted, name: name);
  }
}
