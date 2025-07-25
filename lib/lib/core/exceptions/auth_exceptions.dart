/// 인증 관련 예외 클래스들
class AuthException implements Exception {
  final String message;
  final String? code;
  final dynamic details;

  const AuthException(this.message, {this.code, this.details});

  @override
  String toString() =>
      'AuthException: $message${code != null ? ' (Code: $code)' : ''}';
}

/// Google Sign-In 실패 예외
class GoogleSignInException extends AuthException {
  const GoogleSignInException(super.message, {super.code, super.details});
}

/// Supabase 인증 실패 예외
class SupabaseAuthException extends AuthException {
  const SupabaseAuthException(super.message, {super.code, super.details});
}
