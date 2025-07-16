import 'package:creet/lib/core/exceptions/auth_exceptions.dart'
    as auth_exceptions;
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  /// Google Sign-In을 실행하고 idToken을 반환합니다.
  static Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      return googleAuth.idToken;
    } catch (e) {
      throw auth_exceptions.GoogleSignInException('Google Sign-In failed: $e');
    }
  }

  /// Google Sign-Out을 실행합니다.
  static Future<void> signOut() async {
    await _googleSignIn.signOut();
  }

  /// 현재 Google 사용자 정보를 반환합니다.
  static Future<GoogleSignInAccount?> getCurrentUser() async {
    try {
      return await _googleSignIn.authenticate();
    } catch (e) {
      return null;
    }
  }
}
