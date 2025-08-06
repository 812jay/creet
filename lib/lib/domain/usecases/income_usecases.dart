import 'package:creet/lib/domain/dto/income/income_dto.dart';
import 'package:creet/lib/domain/repositories/income_repository.dart';

class IncomeUseCase {
  final IncomeRepository _incomeRepository;

  IncomeUseCase(this._incomeRepository);

  Future<List<IncomeDto>> fetchIncomes(String userId, String yearMonth) async {
    return _incomeRepository.fetchIncomes(userId, yearMonth);
  }

  Future<void> addIncome(IncomeDto income) async {
    return _incomeRepository.addIncome(income);
  }

  Future<void> deleteIncome(String id) async {
    return _incomeRepository.deleteIncome(id);
  }

  Future<void> updateIncome(IncomeDto income) async {
    return _incomeRepository.updateIncome(income);
  }
}
