import 'package:creet/lib/core/constants/app_colors.dart';
import 'package:creet/lib/core/constants/app_typo.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

enum CalendarType { none, today, outside }

class CalendarWidget extends StatefulWidget {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;
  final Function(DateTime focusedDay) onPageChanged;

  const CalendarWidget({
    super.key,
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
    required this.onPageChanged,
  });

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    widget.onDaySelected(selectedDay, focusedDay);
  }

  void _onPageChanged(DateTime focusedDay) {
    widget.onPageChanged(focusedDay);
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: widget.focusedDay,
      onDaySelected: _onDaySelected,
      onPageChanged: _onPageChanged,
      locale: 'ko_KR',
      calendarStyle: _buildCalendarStyle(),
      headerVisible: false,
      daysOfWeekStyle: _buildDaysOfWeekStyle(),
      weekendDays: const [DateTime.saturday, DateTime.sunday],
      calendarBuilders: _buildCalendarBuilders(),
      calendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.monday,
      rowHeight: 80,
      daysOfWeekHeight: 50,
    );
  }

  CalendarStyle _buildCalendarStyle() {
    return CalendarStyle(
      selectedDecoration: BoxDecoration(
        color: AppColors.backgroundSelectedCalendar,
        shape: BoxShape.circle,
      ),
      selectedTextStyle: AppTypo.body1Medium.copyWith(
        color: AppColors.textInverse,
      ),
      weekendTextStyle: AppTypo.body1Medium.copyWith(
        color: AppColors.calendarSunday,
      ),
      defaultTextStyle: AppTypo.body1Medium.copyWith(
        color: AppColors.textPrimary,
      ),
      outsideTextStyle: AppTypo.body1Medium.copyWith(
        color: AppColors.calendarOutsideDate,
      ),
      cellMargin: const EdgeInsets.all(2),
      cellPadding: const EdgeInsets.all(4),
    );
  }

  DaysOfWeekStyle _buildDaysOfWeekStyle() {
    return DaysOfWeekStyle(
      weekdayStyle: AppTypo.body1Medium.copyWith(color: AppColors.textPrimary),
      weekendStyle: AppTypo.body1Medium.copyWith(
        color: AppColors.calendarSunday,
      ),
    );
  }

  CalendarBuilders _buildCalendarBuilders() {
    return CalendarBuilders(
      outsideBuilder:
          (context, day, focusedDay) => BaseDateWidget(
            type: CalendarType.outside,
            day: day,
            isSelected: false,
          ),
      todayBuilder:
          (context, day, focusedDay) => BaseDateWidget(
            type: CalendarType.today,
            day: day,
            isSelected: isSameDay(widget.selectedDay, day),
            onTap: () => _onDaySelected(day, day),
          ),
      dowBuilder: (context, day) => DayOfWeekWidget(day: day),
      defaultBuilder:
          (context, day, focusedDay) => BaseDateWidget(
            type: CalendarType.none,
            day: day,
            isSelected: isSameDay(widget.selectedDay, day),
            onTap: () => _onDaySelected(day, day),
          ),
    );
  }
}

// 공통 레이아웃을 관리하는 기본 위젯
class BaseDateWidget extends StatelessWidget {
  final CalendarType type;
  final DateTime day;
  final bool isSelected;
  final VoidCallback? onTap;
  final String? income;
  final String? expense;

  const BaseDateWidget({
    super.key,
    required this.type,
    required this.day,
    required this.isSelected,
    this.onTap,
    this.income,
    this.expense,
  });

  Color _getDayColor(int weekday) {
    if (weekday == DateTime.saturday) return AppColors.calendarSaturday;
    if (weekday == DateTime.sunday) return AppColors.calendarSunday;
    return AppColors.textPrimary;
  }

  TextStyle _getDayTextStyle() {
    switch (type) {
      case CalendarType.outside:
        return AppTypo.caption1Regular.copyWith(
          color: AppColors.calendarOutsideDate,
        );
      case CalendarType.today:
      case CalendarType.none:
        return AppTypo.body1Medium.copyWith(color: _getDayColor(day.weekday));
    }
  }

  String _getDayText() {
    switch (type) {
      case CalendarType.today:
        return '오늘';
      case CalendarType.outside:
      case CalendarType.none:
        return '${day.day}';
    }
  }

  Widget _buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          _getDayText(),
          style: _getDayTextStyle(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2),
        Text(
          income != null ? '+$income' : '',
          style: AppTypo.caption1Regular.copyWith(
            color: AppColors.calendarIncome,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          expense != null ? '-$expense' : '',
          style: AppTypo.caption1Regular.copyWith(
            color: AppColors.calendarExpense,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final widget = Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.backgroundSelectedCalendar : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: _buildContent(),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: widget);
    }

    return widget;
  }
}

class DayOfWeekWidget extends StatelessWidget {
  final DateTime day;

  const DayOfWeekWidget({super.key, required this.day});

  String _getDayName(int weekday) {
    const dayNames = ['', '월', '화', '수', '목', '금', '토', '일'];
    return dayNames[weekday];
  }

  Color _getDayColor(int weekday) {
    if (weekday == DateTime.saturday) return AppColors.calendarSaturday;
    if (weekday == DateTime.sunday) return AppColors.calendarSunday;
    return AppColors.textPrimary;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Text(
        _getDayName(day.weekday),
        style: AppTypo.body1Medium.copyWith(color: _getDayColor(day.weekday)),
        textAlign: TextAlign.center,
      ),
    );
  }
}
