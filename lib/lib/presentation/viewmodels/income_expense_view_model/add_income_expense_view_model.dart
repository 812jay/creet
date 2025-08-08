import 'package:creet/lib/core/constants/entry_type.dart';
import 'package:creet/lib/core/di/service_locator.dart';
import 'package:creet/lib/core/utils/logger.dart';
import 'package:creet/lib/domain/dto/income/income_dto.dart';
import 'package:creet/lib/domain/usecases/income_usecases.dart';
import 'package:creet/lib/domain/usecases/user_usecases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_income_expense_view_model.g.dart';

class AddIncomeExpenseState {
  final EntryType selectedType;
  final String expenseAmount;
  final String expenseCategory;
  final String expenseMemo;
  final String incomeAmount;
  final String incomeMemo;
  final bool isSaving;

  const AddIncomeExpenseState({
    this.selectedType = EntryType.expense,
    this.expenseAmount = '0',
    this.expenseCategory = '',
    this.expenseMemo = '',
    this.incomeAmount = '0',
    this.incomeMemo = '',
    this.isSaving = false,
  });

  AddIncomeExpenseState copyWith({
    EntryType? selectedType,
    String? expenseAmount,
    String? expenseCategory,
    String? expenseMemo,
    String? incomeAmount,
    String? incomeMemo,
    bool? isSaving,
  }) {
    return AddIncomeExpenseState(
      selectedType: selectedType ?? this.selectedType,
      expenseAmount: expenseAmount ?? this.expenseAmount,
      expenseCategory: expenseCategory ?? this.expenseCategory,
      expenseMemo: expenseMemo ?? this.expenseMemo,
      incomeAmount: incomeAmount ?? this.incomeAmount,
      incomeMemo: incomeMemo ?? this.incomeMemo,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

@riverpod
class AddIncomeExpenseViewModel extends _$AddIncomeExpenseViewModel {
  late final IncomeUseCase _incomeUseCase;
  late final GetCurrentUserUseCase _getCurrentUserUseCase;

  @override
  AddIncomeExpenseState build() {
    _incomeUseCase = serviceLocator.get<IncomeUseCase>();
    _getCurrentUserUseCase = serviceLocator.get<GetCurrentUserUseCase>();
    return const AddIncomeExpenseState();
  }

  void selectType(EntryType type) {
    state = state.copyWith(selectedType: type);
  }

  void updateExpenseAmount(String amount) {
    state = state.copyWith(expenseAmount: amount);
  }

  void updateExpenseCategory(String category) {
    state = state.copyWith(expenseCategory: category);
  }

  void updateExpenseMemo(String memo) {
    state = state.copyWith(expenseMemo: memo);
  }

  void updateIncomeAmount(String amount) {
    state = state.copyWith(incomeAmount: amount);
  }

  void updateIncomeMemo(String memo) {
    state = state.copyWith(incomeMemo: memo);
  }

  bool get isCompleteEnabled {
    final viewState = state;
    if (viewState.selectedType == EntryType.expense) {
      final clean = viewState.expenseAmount.replaceAll(',', '');
      final amount = int.tryParse(clean) ?? 0;
      return viewState.expenseCategory.isNotEmpty && amount > 0;
    } else {
      final clean = viewState.incomeAmount.replaceAll(',', '');
      final amount = int.tryParse(clean) ?? 0;
      return amount > 0;
    }
  }

  Future<void> save(DateTime date) async {
    final current = state;
    if (!isCompleteEnabled) return;
    state = state.copyWith(isSaving: true);

    try {
      final user = await _getCurrentUserUseCase();
      if (user == null) throw Exception('User not signed in');

      if (current.selectedType == EntryType.income) {
        final clean = current.incomeAmount.replaceAll(',', '');
        final now = DateTime.now();
        final dto = IncomeDto(
          id: 'temp-${now.microsecondsSinceEpoch}',
          userId: user.id,
          categoryId: 'default',
          amount: clean,
          date:
              '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
          description: current.incomeMemo.isEmpty ? null : current.incomeMemo,
          createdAt: now,
          updatedAt: now,
        );
        await _incomeUseCase.addIncome(dto);
      } else {
        // TODO: expense saving when Expense repository/usecase exists
      }
    } catch (e) {
      Logger.error('Save failed: $e', tag: 'IncomeExpenseViewModel');
      rethrow;
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }
}
