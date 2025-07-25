import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String _envFileName = '.env';
  static final String _supabaseUrl = dotenv.env['SUPABASE_URL_DEV'] ?? '';
  static final String _supabaseAnonKey =
      dotenv.env['SUPABASE_ANON_KEY_DEV'] ?? '';

  /// 인증 옵션 설정
  static const _authOptions = FlutterAuthClientOptions(
    authFlowType: AuthFlowType.implicit,
  );

  /// Realtime 옵션 설정
  static const _realtimeOptions = RealtimeClientOptions(
    logLevel: RealtimeLogLevel.info,
  );

  /// Storage 옵션 설정
  static const _storageOptions = StorageClientOptions(retryAttempts: 10);

  /// Supabase 초기화 설정
  static Future<void> initialize() async {
    await dotenv.load(fileName: _envFileName);

    await Supabase.initialize(
      url: _supabaseUrl,
      anonKey: _supabaseAnonKey,
      authOptions: _authOptions,
      realtimeClientOptions: _realtimeOptions,
      storageOptions: _storageOptions,
    );
  }
}
