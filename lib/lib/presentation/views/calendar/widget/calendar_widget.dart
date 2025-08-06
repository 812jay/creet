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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: widget.focusedDay,
        onDaySelected: _onDaySelected,
        onPageChanged: _onPageChanged,
        locale: 'ko_KR',
        calendarStyle: _buildCalendarStyle(),
        headerStyle: _buildHeaderStyle(),
        daysOfWeekStyle: _buildDaysOfWeekStyle(),
        weekendDays: const [DateTime.saturday, DateTime.sunday],
        calendarBuilders: _buildCalendarBuilders(),
        calendarFormat: CalendarFormat.month,
        startingDayOfWeek: StartingDayOfWeek.monday,
        rowHeight: 80,
        daysOfWeekHeight: 50,
      ),
    );
  }

  CalendarStyle _buildCalendarStyle() {
    return const CalendarStyle(
      selectedTextStyle: TextStyle(color: Colors.white),
      weekendTextStyle: TextStyle(color: Colors.red),
      defaultTextStyle: TextStyle(color: Colors.black87),
      outsideTextStyle: TextStyle(color: Colors.grey),
      cellMargin: EdgeInsets.all(2),
      cellPadding: EdgeInsets.all(4),
    );
  }

  HeaderStyle _buildHeaderStyle() {
    return const HeaderStyle(
      formatButtonVisible: false,
      titleCentered: true,
      titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      leftChevronIcon: Icon(Icons.chevron_left, color: Colors.blue),
      rightChevronIcon: Icon(Icons.chevron_right, color: Colors.blue),
    );
  }

  DaysOfWeekStyle _buildDaysOfWeekStyle() {
    return const DaysOfWeekStyle(
      weekdayStyle: TextStyle(color: Colors.black87),
      weekendStyle: TextStyle(color: Colors.red),
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
      child: Column(
        children: [
          Text(
            '${day.day}',
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
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
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                )
                : null,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              '오늘',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '+111,200',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.green,
                fontWeight: FontWeight.w500,
                fontSize: 8,
              ),
            ),
            Text(
              '-52,200',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.red,
                fontWeight: FontWeight.w500,
                fontSize: 8,
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
    switch (weekday) {
      case DateTime.monday:
        return '월';
      case DateTime.tuesday:
        return '화';
      case DateTime.wednesday:
        return '수';
      case DateTime.thursday:
        return '목';
      case DateTime.friday:
        return '금';
      case DateTime.saturday:
        return '토';
      case DateTime.sunday:
        return '일';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSaturday = day.weekday == DateTime.saturday;
    final isSunday = day.weekday == DateTime.sunday;

    Color textColor;
    if (isSaturday) {
      textColor = Colors.blue;
    } else if (isSunday) {
      textColor = Colors.red;
    } else {
      textColor = Colors.black;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Text(
        _getDayName(day.weekday),
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
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

  @override
  Widget build(BuildContext context) {
    final isSaturday = day.weekday == DateTime.saturday;
    final isSunday = day.weekday == DateTime.sunday;

    if (isSelected) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                '${day.day}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Color textColor;
    if (isSaturday) {
      textColor = Colors.blue;
    } else if (isSunday) {
      textColor = Colors.red;
    } else {
      textColor = Colors.black;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(2),
        child: Column(
          children: [
            Text(
              '${day.day}',
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
