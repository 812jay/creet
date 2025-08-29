import 'package:creet/lib/domain/dto/expense/req/expense_req_dto.dart';
import 'package:creet/lib/domain/dto/expense/res/expense_res_dto.dart';
import 'package:creet/lib/domain/repositories/expense_repository.dart';

class ExpenseUseCase {
  final ExpenseRepository _expenseRepository;

  ExpenseUseCase(this._expenseRepository);

  Future<List<ExpenseResDto>> fetchExpenseList(
    String userId,
    String yearMonth,
  ) async {
    return _expenseRepository.fetchExpenseList(userId, yearMonth);
  }

  Future<void> addExpense(ExpenseReqDto expense) async {
    return _expenseRepository.addExpense(expense);
  }

  Future<void> deleteExpense(String id) async {
    return _expenseRepository.deleteExpense(id);
  }

  Future<void> updateExpense(ExpenseResDto expense) async {
    return _expenseRepository.updateExpense(expense);
  }
}
