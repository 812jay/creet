/// 앱 전체에서 사용하는 커스텀 예외 클래스
class CustomException implements Exception {
  final String message;
  final String? code;
  final Exception? originalException;

  const CustomException(this.message, {this.code, this.originalException});

  @override
  String toString() {
    final buffer = StringBuffer('CustomException: $message');
    if (code != null) {
      buffer.write(' (Code: $code)');
    }
    if (originalException != null) {
      buffer.write(' - Original: $originalException');
    }
    return buffer.toString();
  }
}

// /// 사용자 취소를 나타내는 예외 클래스
// class UserCancelledException implements Exception {
//   final String message;

//   const UserCancelledException([this.message = '사용자가 취소했습니다']);

//   @override
//   String toString() => 'UserCancelledException: $message';
// } 