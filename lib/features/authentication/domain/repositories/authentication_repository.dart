import '../entities/botanist.dart';
import '../entities/gardener.dart';
import '../entities/user.dart';

abstract class AuthenticationRepository {
  Future<User?> get user;

  Future<void> signupGardener(Gardener gardener);

  Future<void> signupBotanist(Botanist botanist);

  Future<User?> loginUser({required String email, required String password});

  Future<void> sendPasswordResetLink(String email);

  Future<void> sendEmailVerificationLink();

  Future<void> logoutUser();

  Future<String> updateProfile({
    required String? selectedImagePath,
    required bool picDeleted,
    required String name,
  });
}
