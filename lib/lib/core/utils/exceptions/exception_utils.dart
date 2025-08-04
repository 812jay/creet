/// 예외 타입을 확인하는 유틸리티 메서드들
class ExceptionUtils {
  /// 사용자 취소 관련 예외인지 확인 (Apple Sign-In, Google Sign-In 등)
  static bool isUserCancelled(dynamic exception) {
    final message = exception.toString().toLowerCase();

    // Google Sign-In 취소 확인
    if (message.contains('googlesigninexception') &&
        message.contains('canceled') &&
        message.contains('cancelled by user')) {
      return true;
    }

    // Apple Sign-In 취소 확인
    if (message.contains('cancelled') ||
        message.contains('not_interactive') ||
        message.contains('user_cancelled') ||
        message.contains('apple sign-in 취소됨')) {
      return true;
    }

    return false;
  }

  /// 네트워크 관련 예외인지 확인
  static bool isNetworkError(dynamic exception) {
    final message = exception.toString().toLowerCase();
    return message.contains('network') ||
        message.contains('connection') ||
        message.contains('timeout');
  }

  /// 인증 관련 예외인지 확인
  static bool isAuthError(dynamic exception) {
    final message = exception.toString().toLowerCase();
    return message.contains('auth') ||
        message.contains('unauthorized') ||
        message.contains('forbidden') ||
        message.contains('invalid token');
  }

  /// 데이터베이스 관련 예외인지 확인
  static bool isDatabaseError(dynamic exception) {
    final message = exception.toString().toLowerCase();
    return message.contains('database') ||
        message.contains('sql') ||
        message.contains('constraint') ||
        message.contains('duplicate');
  }

  /// 일반적인 취소 예외인지 확인
  static bool isCancelled(dynamic exception) {
    final message = exception.toString().toLowerCase();
    return message.contains('cancelled') ||
        message.contains('not_interactive') ||
        message.contains('user_cancelled');
  }
}
