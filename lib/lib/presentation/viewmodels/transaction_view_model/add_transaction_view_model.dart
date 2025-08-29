import 'package:creet/lib/core/constants/enum/transaction_enum.dart';
import 'package:creet/lib/core/di/service_locator.dart';
import 'package:creet/lib/core/utils/logger.dart';
import 'package:creet/lib/domain/dto/category/category_dto.dart';
import 'package:creet/lib/domain/dto/expense/req/expense_req_dto.dart';
import 'package:creet/lib/domain/usecases/category_usecases.dart';
import 'package:creet/lib/domain/usecases/expense_usecases.dart';
import 'package:creet/lib/domain/usecases/user_usecases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_transaction_view_model.g.dart';

class TransactionState {
  final TransactionType selectedType;
  final List<CategoryDto> categoryList;

  // Expense 전용 데이터
  final String expenseAmount;
  final CategoryDto? expenseCategory;
  final String expenseMemo;
  final DateTime expenseDateTime;

  // Income 전용 데이터
  final String incomeAmount;
  final String incomeMemo;
  final DateTime incomeDateTime;

  final bool isSaving;

  TransactionState({
    this.selectedType = TransactionType.expense,
    this.categoryList = const [],

    // Expense 초기값
    this.expenseAmount = '0',
    this.expenseCategory,
    this.expenseMemo = '',
    DateTime? expenseDateTime,

    // Income 초기값
    this.incomeAmount = '0',
    this.incomeMemo = '',
    DateTime? incomeDateTime,

    this.isSaving = false,
  }) : expenseDateTime = expenseDateTime ?? DateTime.now(),
       incomeDateTime = incomeDateTime ?? DateTime.now();

  TransactionState copyWith({
    TransactionType? selectedType,
    List<CategoryDto>? categoryList,

    // Expense
    String? expenseAmount,
    CategoryDto? expenseCategory,
    String? expenseMemo,
    DateTime? expenseDateTime,

    // Income
    String? incomeAmount,
    String? incomeMemo,
    DateTime? incomeDateTime,

    bool? isSaving,
  }) {
    return TransactionState(
      selectedType: selectedType ?? this.selectedType,
      categoryList: categoryList ?? this.categoryList,

      expenseAmount: expenseAmount ?? this.expenseAmount,
      expenseCategory: expenseCategory ?? this.expenseCategory,
      expenseMemo: expenseMemo ?? this.expenseMemo,
      expenseDateTime: expenseDateTime ?? this.expenseDateTime,

      incomeAmount: incomeAmount ?? this.incomeAmount,
      incomeMemo: incomeMemo ?? this.incomeMemo,
      incomeDateTime: incomeDateTime ?? this.incomeDateTime,

      isSaving: isSaving ?? this.isSaving,
    );
  }
}

@riverpod
class AddTransactionViewModel extends _$AddTransactionViewModel {
  late final ExpenseUseCase _expenseUseCase;
  late final UserUseCase _userUseCase;
  late final CategoryUseCase _categoryUseCase;
  bool _initialized = false;

  @override
  TransactionState build() {
    _expenseUseCase = serviceLocator.get<ExpenseUseCase>();
    _userUseCase = serviceLocator.get<UserUseCase>();
    _categoryUseCase = serviceLocator.get<CategoryUseCase>();

    return TransactionState();
  }

  void initialize(DateTime initialDate) {
    if (_initialized) return;
    _initialized = true;
    setCategoryList();
    state = state.copyWith(
      expenseDateTime: initialDate,
      incomeDateTime: initialDate,
    );
  }

  Future<void> setCategoryList() async {
    final user = await _userUseCase.getCurrentUser();
    final categoryList = await _categoryUseCase.fetchCategories(user!.id);
    Logger.debug('categoryList: $categoryList', tag: 'AddTransactionViewModel');
    state = state.copyWith(categoryList: categoryList);
  }

  void selectType(TransactionType type) {
    state = state.copyWith(selectedType: type);
  }

  void updateExpenseAmount(String amount) {
    state = state.copyWith(expenseAmount: amount);
  }

  void updateExpenseCategory(CategoryDto category) {
    state = state.copyWith(expenseCategory: category);
  }

  void updateExpenseMemo(String memo) {
    state = state.copyWith(expenseMemo: memo);
  }

  void updateExpenseDateTime(DateTime dateTime) {
    state = state.copyWith(expenseDateTime: dateTime);
  }

  void updateIncomeAmount(String amount) {
    state = state.copyWith(incomeAmount: amount);
  }

  void updateIncomeMemo(String memo) {
    state = state.copyWith(incomeMemo: memo);
  }

  void updateIncomeDateTime(DateTime dateTime) {
    state = state.copyWith(incomeDateTime: dateTime);
  }

  bool get isCompleteEnabled {
    final viewState = state;
    if (viewState.selectedType == TransactionType.expense) {
      final clean = viewState.expenseAmount.replaceAll(',', '');
      final amount = int.tryParse(clean) ?? 0;
      return viewState.expenseCategory != null && amount > 0;
    } else {
      final clean = viewState.incomeAmount.replaceAll(',', '');
      final amount = int.tryParse(clean) ?? 0;
      return amount > 0;
    }
  }

  Future<void> saveExpense({
    required DateTime date,
    required String amount,
    required String categoryId,
    required String description,
    String? memo,
  }) async {
    Logger.debug(
      'saveExpense: $date, $amount, $categoryId, $description, $memo',
      tag: 'AddTransactionViewModel',
    );
    if (!isCompleteEnabled) return;
    state = state.copyWith(isSaving: true);

    final user = await _userUseCase.getCurrentUser();
    if (user == null) throw Exception('User not signed in');

    final parsedAmount = amount.replaceAll(',', '');
    final now = DateTime.now();
    final req = ExpenseReqDto(
      userId: user.id,
      categoryId: categoryId,
      amount: parsedAmount,
      date: date,
      description: memo,
      createdAt: now,
      updatedAt: now,
    );
    await _expenseUseCase.addExpense(req);
  }

  Future<void> saveIncome({
    required DateTime date,
    required String amount,
    required String categoryId,
    required String description,
    String? memo,
  }) async {}
}
