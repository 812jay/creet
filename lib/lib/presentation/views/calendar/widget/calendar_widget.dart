import 'package:creet/lib/core/constants/app_colors.dart';
import 'package:creet/lib/core/constants/app_typo.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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
      outsideBuilder: (context, day, focusedDay) => OutsideDateWidget(day: day),
      todayBuilder:
          (context, day, focusedDay) => TodayDateWidget(
            day: day,
            isSelected: isSameDay(widget.selectedDay, day),
            onTap: () => _onDaySelected(day, day),
          ),
      dowBuilder: (context, day) => DayOfWeekWidget(day: day),
      defaultBuilder:
          (context, day, focusedDay) => DefaultDateWidget(
            day: day,
            isSelected: isSameDay(widget.selectedDay, day),
            onTap: () => _onDaySelected(day, day),
          ),
    );
  }
}

class OutsideDateWidget extends StatelessWidget {
  final DateTime day;

  const OutsideDateWidget({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      child: Text(
        '${day.day}',
        style: AppTypo.caption1Regular.copyWith(
          color: AppColors.calendarOutsideDate,
        ),
      ),
    );
  }
}

class TodayDateWidget extends StatelessWidget {
  final DateTime day;
  final bool isSelected;
  final VoidCallback onTap;

  const TodayDateWidget({
    super.key,
    required this.day,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(4),
        decoration:
            isSelected
                ? BoxDecoration(
                  color: AppColors.backgroundSelectedCalendar,
                  borderRadius: BorderRadius.circular(8),
                )
                : null,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              '오늘',
              style: AppTypo.caption1Medium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '+111,200',
              style: AppTypo.caption1Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              '-52,200',
              style: AppTypo.caption1Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
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
        overflow: TextOverflow.visible,
      ),
    );
  }
}

class DefaultDateWidget extends StatelessWidget {
  final DateTime day;
  final bool isSelected;
  final VoidCallback onTap;

  const DefaultDateWidget({
    super.key,
    required this.day,
    required this.isSelected,
    required this.onTap,
  });

  Color _getDayColor(int weekday) {
    if (weekday == DateTime.saturday) return AppColors.calendarSaturday;
    if (weekday == DateTime.sunday) return AppColors.calendarSunday;
    return AppColors.textPrimary;
  }

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.backgroundSelectedCalendar,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${day.day}',
            style: AppTypo.body1Medium.copyWith(color: AppColors.textPrimary),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(2),
        child: Text(
          '${day.day}',
          style: AppTypo.body1Medium.copyWith(color: _getDayColor(day.weekday)),
        ),
      ),
    );
  }
}
