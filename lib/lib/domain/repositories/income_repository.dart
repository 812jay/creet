import 'package:creet/lib/domain/dto/income/income_dto.dart';

abstract class IncomeRepository {
  Future<void> addIncome(IncomeDto income);
  Future<List<IncomeDto>> fetchIncomes(String userId, String yearMonth);
  Future<void> deleteIncome(String id);
  Future<void> updateIncome(IncomeDto income);
}
