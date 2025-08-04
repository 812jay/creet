import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

/// 로그 레벨 enum
enum LogLevel { debug, info, warning, error }

/// 통합된 로깅 시스템
class Logger {
  static const String _defaultTag = 'App';

  /// 디버그 로그
  static void debug(String message, {String? tag}) {
    _log(LogLevel.debug, message, tag: tag);
  }

  /// 정보 로그
  static void info(String message, {String? tag}) {
    _log(LogLevel.info, message, tag: tag);
  }

  /// 경고 로그
  static void warning(String message, {String? tag}) {
    _log(LogLevel.warning, message, tag: tag);
  }

  /// 에러 로그
  static void error(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.error,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// 내부 로그 처리 메서드
  static void _log(
    LogLevel level,
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    // 릴리즈 모드에서는 debug 로그 제외
    if (!kDebugMode && level == LogLevel.debug) {
      return;
    }

    final logTag = tag ?? _getDefaultTag();
    final timestamp = DateTime.now().toIso8601String();
    final levelString = level.name.toUpperCase();

    final logMessage = '[$timestamp] $levelString [$logTag] $message';

    switch (level) {
      case LogLevel.debug:
        developer.log(logMessage, name: logTag);
        break;
      case LogLevel.info:
        developer.log(logMessage, name: logTag);
        break;
      case LogLevel.warning:
        developer.log(logMessage, name: logTag, level: 900);
        break;
      case LogLevel.error:
        developer.log(
          logMessage,
          name: logTag,
          level: 1000,
          error: error,
          stackTrace: stackTrace,
        );
        break;
    }
  }

  /// 기본 태그 추출 (StackTrace에서 클래스명 가져오기)
  static String _getDefaultTag() {
    try {
      final stackTrace = StackTrace.current;
      final frames = stackTrace.toString().split('\n');

      // 호출 스택에서 클래스명 추출
      for (final frame in frames) {
        if (frame.contains('package:creet/')) {
          // 패키지 경로에서 클래스명 추출
          final match = RegExp(
            r'(\w+)_repository_impl\.dart|(\w+)_view_model\.dart|(\w+)_service\.dart',
          ).firstMatch(frame);
          if (match != null) {
            final className =
                match.group(1) ?? match.group(2) ?? match.group(3);
            return className?.toUpperCase() ?? _defaultTag;
          }
        }
      }
    } catch (e) {
      // 태그 추출 실패 시 기본값 사용
    }

    return _defaultTag;
  }

  /// 성능 측정을 위한 로그
  static void performance(String operation, {String? tag}) {
    if (kDebugMode) {
      info('⏱️ $operation', tag: tag);
    }
  }

  /// 네트워크 요청 로그
  static void network(String method, String url, {String? tag}) {
    if (kDebugMode) {
      info('🌐 $method $url', tag: tag);
    }
  }

  /// 사용자 액션 로그
  static void userAction(String action, {String? tag}) {
    if (kDebugMode) {
      info('👤 $action', tag: tag);
    }
  }
}
