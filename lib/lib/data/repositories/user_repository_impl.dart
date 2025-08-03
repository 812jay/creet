import 'dart:developer' as developer;

import 'package:creet/lib/domain/dto/auth/auth_credential_dto.dart';
import 'package:creet/lib/domain/repositories/user_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepositoryImpl implements UserRepository {
  final SupabaseClient _supabaseClient;

  UserRepositoryImpl(this._supabaseClient);

  @override
  Future<void> signUp(AuthCredentialDto credential) async {
    try {
      developer.log(
        'signUp: ${credential.toJson()}',
        name: 'UserRepositoryImpl',
      );
      final response = await _supabaseClient.from('users').insert({
        'email': credential.email,
        'provider': credential.provider,
        'provider_id': credential.providerId,
        'nickname': credential.displayName,
        'avatar_url': credential.photoURL,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
      print('signUp: $response');
    } catch (e) {
      print('signUp error: $e');
    }
  }
}
