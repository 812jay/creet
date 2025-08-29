import 'package:creet/lib/domain/dto/category/category_dto.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creet/lib/core/constants/app_colors.dart';
// import 'package:creet/lib/core/constants/app_typo.dart';
import 'package:creet/lib/core/constants/enum/transaction_enum.dart';
import 'package:creet/lib/presentation/viewmodels/transaction_view_model/add_transaction_view_model.dart';
import 'package:creet/lib/presentation/widgets/transaction/entry_type_tab_bar.dart';
import 'package:creet/lib/presentation/widgets/transaction/amount_input.dart';
import 'package:creet/lib/presentation/widgets/transaction/date_time_picker_field.dart';
import 'package:creet/lib/presentation/widgets/transaction/memo_input.dart';
import 'package:creet/lib/presentation/widgets/transaction/category_selector.dart';

class AddTransactionView extends ConsumerStatefulWidget {
  final DateTime initialDay;
  const AddTransactionView({super.key, required this.initialDay});

  @override
  ConsumerState<AddTransactionView> createState() => _AddTransactionViewState();
}

class _AddTransactionViewState extends ConsumerState<AddTransactionView> {
  @override
  Widget build(BuildContext context) {
    final viewState = ref.watch(addTransactionViewModelProvider);
    final viewModel = ref.read(addTransactionViewModelProvider.notifier);

    // 초기 지출/수입 초기 설정 (1회)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.initialize(widget.initialDay);
    });

    return GestureDetector(
      onTap: () {
        // 다른 영역 클릭 시 키보드 숨기기
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundDefault,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AppBar(),
              const SizedBox(height: 20),
              EntryTypeTabBar(
                selectedType: viewState.selectedType,
                onChanged: viewModel.selectType,
              ),
              const SizedBox(height: 40),
              Expanded(
                child:
                    viewState.selectedType == TransactionType.expense
                        ? _ExpenseView(
                          amount: viewState.expenseAmount,
                          selectedCategory: viewState.expenseCategory,
                          categoryList: viewState.categoryList,
                          memo: viewState.expenseMemo,
                          dateTime: viewState.expenseDateTime,
                          onAmountChanged: viewModel.updateExpenseAmount,
                          onCategorySelected: viewModel.updateExpenseCategory,
                          onMemoChanged: viewModel.updateExpenseMemo,
                          onDateTimeChanged: viewModel.updateExpenseDateTime,
                          isCompleteButtonEnabled: viewModel.isCompleteEnabled,
                          onCompletePressed: () async {
                            await viewModel.saveExpense(
                              date: viewState.expenseDateTime,
                              amount: viewState.expenseAmount,
                              categoryId: viewState.expenseCategory!.id,
                              description: viewState.expenseMemo,
                              memo: viewState.expenseMemo,
                            );
                            if (context.mounted) Navigator.of(context).pop();
                          },
                        )
                        : _IncomeView(
                          amount: viewState.incomeAmount,
                          memo: viewState.incomeMemo,
                          dateTime: viewState.incomeDateTime,
                          onAmountChanged: viewModel.updateIncomeAmount,
                          onMemoChanged: viewModel.updateIncomeMemo,
                          onDateTimeChanged: viewModel.updateIncomeDateTime,
                          isCompleteButtonEnabled: viewModel.isCompleteEnabled,
                          onCompletePressed: () async {
                            await viewModel.saveIncome(
                              date: viewState.incomeDateTime,
                              amount: viewState.incomeAmount,
                              categoryId: 'default', // 수입은 기본 카테고리 사용
                              description: viewState.incomeMemo,
                              memo: viewState.incomeMemo,
                            );
                            if (context.mounted) Navigator.of(context).pop();
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: SizedBox(
          width: 32,
          height: 32,
          child: SvgPicture.asset('assets/icons/arrow_left.svg'),
        ),
      ),
    );
  }
}

// Moved to widgets: EntryTypeTabBar

class _ExpenseView extends StatelessWidget {
  final String amount;
  final CategoryDto? selectedCategory;
  final List<CategoryDto>? categoryList;
  final String memo;
  final DateTime dateTime;
  final Function(String) onAmountChanged;
  final Function(CategoryDto) onCategorySelected;
  final Function(String) onMemoChanged;
  final Function(DateTime) onDateTimeChanged;
  final bool isCompleteButtonEnabled;
  final VoidCallback onCompletePressed;

  const _ExpenseView({
    required this.amount,
    this.selectedCategory,
    this.categoryList,
    required this.memo,
    required this.dateTime,
    required this.onAmountChanged,
    required this.onCategorySelected,
    required this.onMemoChanged,
    required this.onDateTimeChanged,
    required this.isCompleteButtonEnabled,
    required this.onCompletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AmountInput(amount: amount, onChanged: onAmountChanged),
          const SizedBox(height: 40),
          CategorySelector(
            selectedCategory: selectedCategory,
            onSelected: (category) => onCategorySelected(category),
            categorieList: categoryList ?? [],
          ),
          const SizedBox(height: 20),
          DateTimePickerField(
            type: TransactionType.expense,
            dateTime: dateTime,
            onChanged: onDateTimeChanged,
          ),
          const SizedBox(height: 20),
          MemoInput(memo: memo, onChanged: onMemoChanged),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: isCompleteButtonEnabled ? onCompletePressed : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isCompleteButtonEnabled
                        ? AppColors.backgroundDefaultInButton
                        : AppColors.textDisabled,
                foregroundColor: AppColors.textInverse,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text('완료'),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _IncomeView extends StatelessWidget {
  final String amount;
  final String memo;
  final DateTime dateTime;
  final Function(String) onAmountChanged;
  final Function(String) onMemoChanged;
  final Function(DateTime) onDateTimeChanged;
  final bool isCompleteButtonEnabled;
  final VoidCallback onCompletePressed;

  const _IncomeView({
    required this.amount,
    required this.memo,
    required this.dateTime,
    required this.onAmountChanged,
    required this.onMemoChanged,
    required this.onDateTimeChanged,
    required this.isCompleteButtonEnabled,
    required this.onCompletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AmountInput(amount: amount, onChanged: onAmountChanged),
          const SizedBox(height: 20),
          DateTimePickerField(
            type: TransactionType.income,
            dateTime: dateTime,
            onChanged: onDateTimeChanged,
          ),
          const SizedBox(height: 20),
          MemoInput(memo: memo, onChanged: onMemoChanged),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: isCompleteButtonEnabled ? onCompletePressed : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isCompleteButtonEnabled
                        ? AppColors.backgroundDefaultInButton
                        : AppColors.textDisabled,
                foregroundColor: AppColors.textInverse,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text('완료'),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
