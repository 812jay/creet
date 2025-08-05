import 'package:creet/lib/core/utils/exceptions/custom_exception.dart';
import 'package:creet/lib/core/utils/exceptions/exception_utils.dart';
import 'package:creet/lib/core/utils/exceptions/result.dart';
import 'package:creet/lib/core/utils/logger.dart';

/// 비동기 작업을 안전하게 처리하는 래퍼 클래스
class AsyncWrapper {
  /// 안전한 비동기 함수 실행을 위한 래퍼
  static Future<T?> wrap<T>(
    Future<T> Function() operation, {
    String? operationName,
    String? errorMessage,
    bool shouldRethrow = false,
    bool handleUserCancellation = false,
  }) async {
    try {
      return await operation();
    } catch (e, stackTrace) {
      // 사용자 취소 처리
      if (handleUserCancellation && ExceptionUtils.isUserCancelled(e)) {
        Logger.info(
          '${operationName ?? 'Operation'} cancelled by user',
          tag: 'AsyncWrapper',
        );
        throw const CustomException('사용자가 취소했습니다', code: 'USER_CANCELLED');
      }

      final exception = CustomException(
        errorMessage ?? 'Operation failed',
        originalException: e is Exception ? e : Exception(e.toString()),
      );

      Logger.error(
        '${operationName ?? 'Operation'} failed: ${exception.message}',
        tag: 'AsyncWrapper',
        error: e,
        stackTrace: stackTrace,
      );

      if (shouldRethrow) {
        throw exception;
      }
      return null;
    }
  }

  /// 결과를 반환하는 안전한 비동기 함수 실행
  static Future<Result<T>> wrapWithResult<T>(
    Future<T> Function() operation, {
    String? operationName,
    String? errorMessage,
    bool handleUserCancellation = false,
  }) async {
    try {
      final result = await operation();
      return Result.success(result);
    } catch (e, stackTrace) {
      // 사용자 취소 처리
      if (handleUserCancellation && ExceptionUtils.isUserCancelled(e)) {
        Logger.info(
          '${operationName ?? 'Operation'} cancelled by user',
          tag: 'AsyncWrapper',
        );
        return Result.failure('사용자가 취소했습니다');
      }

      final exception = CustomException(
        errorMessage ?? 'Operation failed',
        originalException: e is Exception ? e : Exception(e.toString()),
      );

      Logger.error(
        '${operationName ?? 'Operation'} failed: ${exception.message}',
        tag: 'AsyncWrapper',
        error: e,
        stackTrace: stackTrace,
      );

      return Result.failure(exception.message);
    }
  }
}
