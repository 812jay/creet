import 'package:creet/lib/domain/dto/income/income_dto.dart';
import 'package:creet/lib/domain/repositories/income_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IncomeRepositoryImpl extends IncomeRepository {
  final SupabaseClient _supabaseClient;

  IncomeRepositoryImpl(this._supabaseClient);

  @override
  Future<void> addIncome(IncomeDto income) async {
    await _supabaseClient.from('incomes').insert(income.toJson());
  }

  @override
  Future<List<IncomeDto>> fetchIncomes(String userId, String yearMonth) async {
    final response = await _supabaseClient
        .from('incomes')
        .select('*')
        .eq('user_id', userId)
        .eq('date', '$yearMonth-01');

    return response.map((e) => IncomeDto.fromJson(e)).toList();
  }

  @override
  Future<void> deleteIncome(String id) async {
    await _supabaseClient.from('incomes').delete().eq('id', id);
  }

  @override
  Future<void> updateIncome(IncomeDto income) async {
    await _supabaseClient
        .from('incomes')
        .update(income.toJson())
        .eq('id', income.id);
  }
}
