import 'package:creet/lib/domain/dto/user/user_dto.dart';

abstract class AuthRepository {
  Future<UserDto?> signInWithGoogle();
  Future<UserDto?> signInWithApple();
  Future<void> signOut();
  Future<UserDto?> getCurrentUser();
  Stream<UserDto?> get authStateChanges;
}
