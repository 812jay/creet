import 'package:creet/lib/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> signInWithGoogle();
  Future<UserEntity?> signInWithApple();
  Future<void> signOut();
  Future<UserEntity?> getCurrentUser();
  Stream<UserEntity?> get authStateChanges;
}
