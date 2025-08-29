import 'package:creet/lib/domain/dto/expense/req/expense_req_dto.dart';
import 'package:creet/lib/domain/dto/expense/res/expense_res_dto.dart';

abstract class ExpenseRepository {
  Future<void> addExpense(ExpenseReqDto expense);
  Future<List<ExpenseResDto>> fetchExpenseList(String userId, String yearMonth);
  Future<void> deleteExpense(String id);
  Future<void> updateExpense(ExpenseResDto expense);
}
