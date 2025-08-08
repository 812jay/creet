import 'package:creet/lib/core/constants/app_colors.dart';
import 'package:creet/lib/core/constants/app_typo.dart';
import 'package:creet/lib/core/constants/entry_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTimePickerField extends StatelessWidget {
  final EntryType type;
  final DateTime dateTime;
  final ValueChanged<DateTime> onChanged;

  const DateTimePickerField({
    super.key,
    required this.type,
    required this.dateTime,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showPicker(context),
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
                type == EntryType.expense ? '지출 일시' : '수입 일시',
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

  void _showPicker(BuildContext context) {
    DateTime temp = dateTime;
    showCupertinoModalPopup<void>(
      context: context,
      builder: (ctx) {
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
                    onDateTimeChanged: (val) => temp = val,
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
