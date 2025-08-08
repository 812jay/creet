import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creet/lib/core/constants/app_colors.dart';
import 'package:creet/lib/core/constants/app_typo.dart';
import 'package:creet/lib/core/constants/entry_type.dart';
import 'package:creet/lib/presentation/viewmodels/income_expense_view_model/add_income_expense_view_model.dart';

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
              _TabSection(
                selectedType: viewState.selectedType,
                onTabChanged: viewModel.selectType,
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

class _TabSection extends StatelessWidget {
  final EntryType selectedType;
  final Function(EntryType) onTabChanged;

  const _TabSection({required this.selectedType, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _TabButton(
            text: '지출',
            isSelected: selectedType == EntryType.expense,
            onTap: () => onTabChanged(EntryType.expense),
          ),
          const SizedBox(width: 32),
          _TabButton(
            text: '수입',
            isSelected: selectedType == EntryType.income,
            onTap: () => onTabChanged(EntryType.income),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            text,
            style:
                isSelected
                    ? AppTypo.title1Bold.copyWith(color: AppColors.textPrimary)
                    : AppTypo.title1Medium.copyWith(
                      color: AppColors.textSecondary,
                    ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 2,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.textPrimary : Colors.transparent,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }
}

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
          _AmountSection(amount: amount, onAmountChanged: onAmountChanged),
          const SizedBox(height: 40),
          _CategorySection(
            selectedCategory: selectedCategory,
            onCategorySelected: onCategorySelected,
            categories: [
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
          _DateTimeSection(
            selectedType: EntryType.expense,
            dateTime: dateTime,
            onChanged: onDateTimeChanged,
          ),
          const SizedBox(height: 20),
          _MemoSection(memo: memo, onMemoChanged: onMemoChanged),
          const Spacer(),
          _CompleteButton(
            isEnabled: isCompleteButtonEnabled,
            onPressed: onCompletePressed,
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
          _AmountSection(amount: amount, onAmountChanged: onAmountChanged),
          const SizedBox(height: 20),
          _DateTimeSection(
            selectedType: EntryType.income,
            dateTime: dateTime,
            onChanged: onDateTimeChanged,
          ),
          const SizedBox(height: 20),
          _MemoSection(memo: memo, onMemoChanged: onMemoChanged),
          const Spacer(),
          _CompleteButton(
            isEnabled: isCompleteButtonEnabled,
            onPressed: onCompletePressed,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _AmountSection extends StatefulWidget {
  final String amount;
  final Function(String) onAmountChanged;

  const _AmountSection({required this.amount, required this.onAmountChanged});

  @override
  State<_AmountSection> createState() => _AmountSectionState();
}

class _AmountSectionState extends State<_AmountSection> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.amount.replaceAll(',', ''),
    );
    _focusNode = FocusNode();

    // 포커스 리스너 추가
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _finishEditing();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditing) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: IntrinsicWidth(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  _NoLeadingZeroFormatter(),
                  _CurrencyInputFormatter(),
                ],
                style: AppTypo.title1Bold.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 32,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '0',
                  hintStyle: AppTypo.title1Bold.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 32,
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                autofocus: true,
                onChanged: (value) {
                  // 실시간으로 변경사항 반영
                  if (value.isNotEmpty) {
                    // 이미 _CurrencyInputFormatter에서 포맷팅되어 온 값을 사용
                    widget.onAmountChanged(value);
                  } else {
                    widget.onAmountChanged('0');
                  }
                },
                onSubmitted: (value) {
                  _finishEditing();
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              '원',
              style: AppTypo.title1Bold.copyWith(
                color: AppColors.textPrimary,
                fontSize: 24,
              ),
            ),
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _isEditing = true;
          _controller.text = widget.amount.replaceAll(',', '');
        });
        // 포커스 요청
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _focusNode.requestFocus();
          // 키보드 강제 표시
          SystemChannels.textInput.invokeMethod('TextInput.show');
        });
      },
      child: Container(
        width: double.infinity,
        color: Colors.transparent, // 전체 영역 탭 가능하게 만들기
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              widget.amount,
              style: AppTypo.title1Bold.copyWith(
                color: AppColors.textPrimary,
                fontSize: 32,
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '원',
                style: AppTypo.title1Bold.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _finishEditing() {
    setState(() {
      _isEditing = false;
    });

    final newAmount = _controller.text;
    if (newAmount.isNotEmpty) {
      final formattedAmount = _formatAmount(newAmount);
      widget.onAmountChanged(formattedAmount);
    }
  }

  String _formatAmount(String amount) {
    // 숫자만 추출
    final cleanAmount = amount.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanAmount.isEmpty) return '0';

    // 숫자를 쉼표로 포맷팅
    final number = int.parse(cleanAmount);
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match match) => '${match[1]},',
    );
  }
}

class _CategorySection extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;
  final List<String> categories;

  const _CategorySection({
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showCategoryDialog(context);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.componentLineDefault),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedCategory.isEmpty ? '카테고리를 선택해 주세요' : selectedCategory,
                style:
                    selectedCategory.isEmpty
                        ? AppTypo.body1Medium.copyWith(
                          color: AppColors.textSecondary,
                        )
                        : AppTypo.body1Medium.copyWith(
                          color: AppColors.textPrimary,
                        ),
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 20),
          ],
        ),
      ),
    );
  }

  void _showCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('카테고리 선택', style: AppTypo.title1Bold),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(categories[index], style: AppTypo.body1Medium),
                  onTap: () {
                    onCategorySelected(categories[index]);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _MemoSection extends StatelessWidget {
  final String memo;
  final Function(String) onMemoChanged;

  const _MemoSection({required this.memo, required this.onMemoChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.componentLineDefault),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: TextEditingController(text: memo)
          ..selection = TextSelection.fromPosition(
            TextPosition(offset: memo.length),
          ),
        onChanged: onMemoChanged,
        maxLength: 100,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '메모를 입력하세요 (선택사항)',
          hintStyle: AppTypo.body1Medium.copyWith(
            color: AppColors.textSecondary,
          ),
          counterStyle: AppTypo.caption1Regular.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        style: AppTypo.body1Medium.copyWith(color: AppColors.textPrimary),
        maxLines: 3,
        minLines: 1,
      ),
    );
  }
}

class _DateTimeSection extends StatelessWidget {
  final EntryType selectedType;
  final DateTime dateTime;
  final ValueChanged<DateTime> onChanged;

  const _DateTimeSection({
    required this.selectedType,
    required this.dateTime,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showCupertinoDateTimePicker(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.componentLineDefault),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedType == EntryType.expense ? '지출 일시' : '수입 일시',
                style: AppTypo.body1Medium,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              '${_formatDate(context, dateTime)}  ${_formatTime(context, dateTime)}',
              style: AppTypo.body1Medium.copyWith(color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(BuildContext context, DateTime dt) {
    final l10n = MaterialLocalizations.of(context);
    return l10n.formatMediumDate(dt);
  }

  String _formatTime(BuildContext context, DateTime dt) {
    final l10n = MaterialLocalizations.of(context);
    return l10n.formatTimeOfDay(
      TimeOfDay.fromDateTime(dt),
      alwaysUse24HourFormat: false,
    );
  }

  void _showCupertinoDateTimePicker(BuildContext context) {
    DateTime temp = dateTime;
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          height: 300,
          color: AppColors.backgroundDefault,
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                SizedBox(
                  height: 44,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('취소', style: AppTypo.body1Medium),
                        onPressed: () => Navigator.of(ctx).pop(),
                      ),
                      CupertinoButton(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('완료', style: AppTypo.body1Medium),
                        onPressed: () {
                          onChanged(temp);
                          Navigator.of(ctx).pop();
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,
                    initialDateTime: dateTime,
                    use24hFormat: false,
                    onDateTimeChanged: (val) {
                      temp = val;
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CompleteButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;

  const _CompleteButton({required this.isEnabled, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isEnabled
                  ? AppColors.backgroundDefaultInButton
                  : AppColors.textDisabled,
          foregroundColor: AppColors.textInverse,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: Text(
          '완료',
          style: AppTypo.title1Bold.copyWith(color: AppColors.textInverse),
        ),
      ),
    );
  }
}

// 0으로 시작하는 입력을 방지하는 TextInputFormatter
class _NoLeadingZeroFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 빈 문자열이면 그대로 반환
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // 0으로 시작하고 길이가 1보다 크면 0 제거
    if (newValue.text.startsWith('0') && newValue.text.length > 1) {
      final newText = newValue.text.substring(1);
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }

    return newValue;
  }
}

// 실시간 쉼표 포맷팅을 위한 TextInputFormatter
class _CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // 숫자만 추출
    final cleanText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanText.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // 쉼표로 포맷팅
    final formattedText = _formatWithCommas(cleanText);

    // 커서 위치 계산
    final newCursorPosition = formattedText.length;

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: newCursorPosition),
    );
  }

  String _formatWithCommas(String amount) {
    if (amount.isEmpty) return '0';

    final number = int.parse(amount);
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match match) => '${match[1]},',
    );
  }
}
