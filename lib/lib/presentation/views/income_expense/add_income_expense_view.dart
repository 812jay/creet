import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creet/lib/core/constants/app_colors.dart';
// import 'package:creet/lib/core/constants/app_typo.dart';
import 'package:creet/lib/core/constants/entry_type.dart';
import 'package:creet/lib/presentation/viewmodels/income_expense_view_model/add_income_expense_view_model.dart';
import 'package:creet/lib/presentation/widgets/income_expense/entry_type_tab_bar.dart';
import 'package:creet/lib/presentation/widgets/income_expense/amount_input.dart';
import 'package:creet/lib/presentation/widgets/income_expense/date_time_picker_field.dart';
import 'package:creet/lib/presentation/widgets/income_expense/memo_input.dart';
import 'package:creet/lib/presentation/widgets/income_expense/category_selector.dart';
// import 'package:creet/lib/presentation/widgets/income_expense/complete_button.dart';

class AddIncomeExpenseView extends ConsumerStatefulWidget {
  final DateTime initialDay;
  const AddIncomeExpenseView({super.key, required this.initialDay});

  @override
  ConsumerState<AddIncomeExpenseView> createState() =>
      _AddIncomeExpenseViewState();
}

class _AddIncomeExpenseViewState extends ConsumerState<AddIncomeExpenseView> {
  @override
  Widget build(BuildContext context) {
    final viewState = ref.watch(addIncomeExpenseViewModelProvider);
    final viewModel = ref.read(addIncomeExpenseViewModelProvider.notifier);

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
                    viewState.selectedType == EntryType.expense
                        ? _ExpenseView(
                          amount: viewState.expenseAmount,
                          selectedCategory: viewState.expenseCategory,
                          memo: viewState.expenseMemo,
                          dateTime: viewState.expenseDateTime,
                          onAmountChanged: viewModel.updateExpenseAmount,
                          onCategorySelected: viewModel.updateExpenseCategory,
                          onMemoChanged: viewModel.updateExpenseMemo,
                          onDateTimeChanged: viewModel.updateExpenseDateTime,
                          isCompleteButtonEnabled: viewModel.isCompleteEnabled,
                          onCompletePressed: () async {
                            await viewModel.save();
                            if (context.mounted) Navigator.of(context).pop();
                          },
                        )
                        : _IncomeView(
                          amount: viewState.incomeAmount,
                          selectedCategory: '',
                          memo: viewState.incomeMemo,
                          dateTime: viewState.incomeDateTime,
                          onAmountChanged: viewModel.updateIncomeAmount,
                          onMemoChanged: viewModel.updateIncomeMemo,
                          onDateTimeChanged: viewModel.updateIncomeDateTime,
                          isCompleteButtonEnabled: viewModel.isCompleteEnabled,
                          onCompletePressed: () async {
                            await viewModel.save();
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
  final String selectedCategory;
  final String memo;
  final DateTime dateTime;
  final Function(String) onAmountChanged;
  final Function(String) onCategorySelected;
  final Function(String) onMemoChanged;
  final Function(DateTime) onDateTimeChanged;
  final bool isCompleteButtonEnabled;
  final VoidCallback onCompletePressed;

  const _ExpenseView({
    required this.amount,
    required this.selectedCategory,
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
            onSelected: onCategorySelected,
            categories: const [
              '식비',
              '교통비',
              '주거비',
              '통신비',
              '의료비',
              '교육비',
              '문화생활비',
              '기타',
            ],
          ),
          const SizedBox(height: 20),
          DateTimePickerField(
            type: EntryType.expense,
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
  final String selectedCategory;
  final String memo;
  final DateTime dateTime;
  final Function(String) onAmountChanged;
  final Function(String) onMemoChanged;
  final Function(DateTime) onDateTimeChanged;
  final bool isCompleteButtonEnabled;
  final VoidCallback onCompletePressed;

  const _IncomeView({
    required this.amount,
    required this.selectedCategory,
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
            type: EntryType.income,
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
