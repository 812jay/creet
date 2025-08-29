import 'package:creet/lib/core/constants/app_colors.dart';
import 'package:creet/lib/core/constants/app_typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creet/lib/presentation/viewmodels/calendar/calendar_view_model.dart';
import 'package:creet/lib/presentation/widgets/calendar/calendar_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDefault,
      body: SafeArea(
        child: Column(
          children: [
            _CalendarBody(),
            Container(height: 20, color: AppColors.backgroundGray),
            Expanded(child: _ConsumptoinHistory()),
          ],
        ),
      ),
    );
  }
}

class _CalendarBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: [_CalendarAppBar(), _CalendarContent()]),
    );
  }
}

class _CalendarAppBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calendarViewModelProvider);
    return state.when(
      data: (calendarState) => _buildAppBar(calendarState.focusedDay),
      loading: () => _buildAppBar(DateTime.now()),
      error: (error, stack) => _buildAppBar(DateTime.now()),
    );
  }

  Widget _buildAppBar(DateTime focusedDay) {
    final monthFormat = DateFormat('yyyy년 M월', 'ko_KR');

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Text(
            monthFormat.format(focusedDay),
            style: AppTypo.title1Bold.copyWith(color: AppColors.textPrimary),
          ),
          const Spacer(),
          _AppBarButton(
            text: '고정지출',
            onTap: () {
              // TODO: 고정지출 페이지로 이동
            },
          ),
          const SizedBox(width: 16),
          _AppBarButton(
            text: '통계',
            onTap: () {
              // TODO: 통계 페이지로 이동
            },
          ),
        ],
      ),
    );
  }
}

class _AppBarButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _AppBarButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: AppTypo.body1Medium.copyWith(color: AppColors.textPrimary),
      ),
    );
  }
}

class _CalendarContent extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calendarViewModelProvider);
    return state.when(
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
          (error, stack) =>
              Center(child: _ErrorMessage(message: '오류가 발생했습니다: $error')),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  final String message;

  const _ErrorMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(Icons.error_outline, color: AppColors.statusError, size: 48),
          const SizedBox(height: 8),
          Text(
            message,
            style: AppTypo.body1Medium.copyWith(color: AppColors.statusError),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SelectedDateInfo extends StatelessWidget {
  final AsyncValue<CalendarState> state;

  const _SelectedDateInfo({required this.state});

  @override
  Widget build(BuildContext context) {
    return state.when(
      data:
          (calendarState) =>
              _SelectedDateCard(selectedDay: calendarState.selectedDay),
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }
}

class _SelectedDateCard extends StatelessWidget {
  final DateTime selectedDay;

  const _SelectedDateCard({required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.componentFillAlternative,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.componentLineDefault),
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today,
            color: AppColors.statusInformative,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '선택된 날짜: ${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day}일',
              style: AppTypo.body1Medium,
            ),
          ),
        ],
      ),
    );
  }
}

class _ConsumptoinHistory extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarState = ref.watch(calendarViewModelProvider);
    final selectedDay = calendarState.value?.selectedDay;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          _SelectedDateInfo(state: calendarState),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                context.push(
                  '/transaction',
                  extra: {'initialDay': selectedDay},
                );
              },
              child: Text('거래내역 등록', style: AppTypo.title1Bold),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: 10,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16);
              },
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.componentFillPrimary,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.componentLineDefault),
                  ),
                  child: Center(
                    child: Text('Item $index', style: AppTypo.body1Medium),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
