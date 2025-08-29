import 'package:creet/lib/domain/dto/expense/req/expense_req_dto.dart';
import 'package:creet/lib/domain/dto/expense/res/expense_res_dto.dart';
import 'package:creet/lib/domain/repositories/expense_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExpenseRepositoryImpl extends ExpenseRepository {
  final SupabaseClient _supabaseClient;

  ExpenseRepositoryImpl(this._supabaseClient);

  @override
  Future<void> addExpense(ExpenseReqDto expense) async {
    await _supabaseClient.from('expenses').insert(expense.toJson());
  }

  @override
  Future<List<ExpenseResDto>> fetchExpenseList(
    String userId,
    String yearMonth,
  ) async {
    final response = await _supabaseClient
        .from('expenses')
        .select('*')
        .eq('user_id', userId)
        .lt('date', '$yearMonth-01');

    return response.map((e) => ExpenseResDto.fromJson(e)).toList();
  }

  @override
  Future<void> deleteExpense(String id) async {
    await _supabaseClient.from('expenses').delete().eq('id', id);
  }

  @override
  Future<void> updateExpense(ExpenseResDto expense) async {
    await _supabaseClient
        .from('expenses')
        .update(expense.toJson())
        .eq('id', expense.id);
  }
}
