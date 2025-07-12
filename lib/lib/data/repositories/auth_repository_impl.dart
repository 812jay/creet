import 'package:creet/lib/data/datasources/user_dto.dart';
import 'package:creet/lib/domain/entities/user_entity.dart';
import 'package:creet/lib/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepositoryImpl(this._firebaseAuth, this._googleSignIn);

  @override
  Future<UserEntity?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Firebase User -> UserDto -> UserEntity
        final userDto = UserDto(
          userId: user.uid,
          email: user.email ?? '',
          displayName: user.displayName,
          profileUrl: user.photoURL,
        );
        return userDto.toEntity();
      }
      return null;
    } catch (e) {
      throw Exception('Google sign in failed: $e');
    }
  }

  @override
  Future<void> signOut() async {
    await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final User? user = _firebaseAuth.currentUser;
    if (user != null) {
      final userDto = UserDto(
        userId: user.uid,
        email: user.email ?? '',
        displayName: user.displayName,
        profileUrl: user.photoURL,
      );
      return userDto.toEntity();
    }
    return null;
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((User? user) {
      if (user != null) {
        final userDto = UserDto(
          userId: user.uid,
          email: user.email ?? '',
          displayName: user.displayName,
          profileUrl: user.photoURL,
        );
        return userDto.toEntity();
      }
      return null;
    });
  }
}
