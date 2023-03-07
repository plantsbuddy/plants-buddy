abstract class AuthenticationRepository {
  Future<void> signupUser({
    required String name,
    required String email,
    required String password,
  });

  Future<void> loginUser({required String email, required String password});

  Future<void> sendPasswordResetLink(String email);

  Future<void> sendEmailVerificationLink();

  Future<void> updateUsername(String name);

  Future<void> updateProfilePicture(String picturePath);
}
