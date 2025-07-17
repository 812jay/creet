import 'package:creet/lib/core/exceptions/auth_exceptions.dart'
    as auth_exceptions;
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  static Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      return googleAuth.idToken;
    } catch (e) {
      throw auth_exceptions.GoogleSignInException('Google Sign-In failed: $e');
    }
  }

  static Future<void> signOut() async {
    await _googleSignIn.signOut();
  }

  static Future<GoogleSignInAccount?> getCurrentUser() async {
    try {
      return await _googleSignIn.authenticate();
    } catch (e) {
      return null;
    }
  }
}
