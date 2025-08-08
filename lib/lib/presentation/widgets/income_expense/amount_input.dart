import 'package:creet/lib/core/constants/app_colors.dart';
import 'package:creet/lib/core/constants/app_typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountInput extends StatefulWidget {
  final String amount;
  final ValueChanged<String> onChanged;

  const AmountInput({super.key, required this.amount, required this.onChanged});

  @override
  State<AmountInput> createState() => _AmountInputState();
}

class _AmountInputState extends State<AmountInput> {
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
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) _finishEditing();
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
                onChanged:
                    (value) => widget.onChanged(value.isNotEmpty ? value : '0'),
                onSubmitted: (_) => _finishEditing(),
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
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => _focusNode.requestFocus(),
        );
      },
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
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
    setState(() => _isEditing = false);
    final newAmount = _controller.text;
    if (newAmount.isNotEmpty) {
      final formatted = _formatAmount(newAmount);
      widget.onChanged(formatted);
    }
  }

  String _formatAmount(String amount) {
    final clean = amount.replaceAll(RegExp(r'[^\d]'), '');
    if (clean.isEmpty) return '0';
    final number = int.parse(clean);
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }
}

class _NoLeadingZeroFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;
    if (newValue.text.startsWith('0') && newValue.text.length > 1) {
      final text = newValue.text.substring(1);
      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
    return newValue;
  }
}

class _CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;
    final clean = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    if (clean.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }
    final formatted = _withCommas(clean);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _withCommas(String amount) {
    if (amount.isEmpty) return '0';
    final number = int.parse(amount);
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }
}
