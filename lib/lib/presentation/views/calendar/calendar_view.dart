import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creet/lib/presentation/viewmodels/calendar/calendar_view_model.dart';
import 'package:creet/lib/presentation/views/calendar/widget/calendar_widget.dart';

class CalendarView extends ConsumerWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarAsync = ref.watch(calendarViewModelProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            calendarAsync.when(
              data:
                  (calendarState) => CalendarWidget(
                    selectedDay: calendarState.selectedDay,
                    focusedDay: calendarState.focusedDay,
                    onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                      ref
                          .read(calendarViewModelProvider.notifier)
                          .selectDay(selectedDay);
                    },
                    onPageChanged: (DateTime focusedDay) {
                      ref
                          .read(calendarViewModelProvider.notifier)
                          .changeFocusedDay(focusedDay);
                    },
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error:
                  (error, stack) => Center(child: Text('오류가 발생했습니다: $error')),
            ),
            const SizedBox(height: 20),
            _buildSelectedDateInfo(ref),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedDateInfo(WidgetRef ref) {
    final calendarAsync = ref.watch(calendarViewModelProvider);

    return calendarAsync.when(
      data:
          (calendarState) => Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.blue),
                const SizedBox(width: 12),
                Text(
                  '선택된 날짜: ${calendarState.selectedDay.year}년 ${calendarState.selectedDay.month}월 ${calendarState.selectedDay.day}일',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }
}
