import 'package:creet/lib/data/repositories/auth_repository_impl.dart';
import 'package:creet/lib/domain/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Supabase Client Provider
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

// Dio HTTP Client Provider
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  // Add interceptors for logging, auth headers, etc.
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  return dio;
});

// SharedPreferences Provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be initialized');
});

// SharedPreferences Future Provider
final sharedPreferencesFutureProvider = FutureProvider<SharedPreferences>((
  ref,
) async {
  return await SharedPreferences.getInstance();
});

// Repository Providers
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return AuthRepositoryImpl(supabaseClient);
});
