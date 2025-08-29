import 'package:creet/lib/core/di/service_locator.dart';
import 'package:creet/lib/core/utils/logger.dart';
import 'package:creet/lib/domain/usecases/expense_usecases.dart';
import 'package:creet/lib/domain/usecases/user_usecases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'calendar_view_model.g.dart';

/// 캘린더 상태를 관리하는 클래스
class CalendarState {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final List<CalendarEvent> events;
  final bool isLoading;

  const CalendarState({
    required this.selectedDay,
    required this.focusedDay,
    required this.events,
    this.isLoading = false,
  });

  CalendarState copyWith({
    DateTime? selectedDay,
    DateTime? focusedDay,
    List<CalendarEvent>? events,
    bool? isLoading,
  }) {
    return CalendarState(
      selectedDay: selectedDay ?? this.selectedDay,
      focusedDay: focusedDay ?? this.focusedDay,
      events: events ?? this.events,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// 캘린더 이벤트 클래스
class CalendarEvent {
  final String id;
  final String title;
  final DateTime date;
  final String? description;
  final EventType type;

  const CalendarEvent({
    required this.id,
    required this.title,
    required this.date,
    this.description,
    this.type = EventType.general,
  });
}

/// 이벤트 타입 enum
enum EventType { general, important, reminder, meeting }

@riverpod
class CalendarViewModel extends _$CalendarViewModel {
  final expenseUsecases = serviceLocator.get<ExpenseUseCase>();
  final userUsecases = serviceLocator.get<UserUseCase>();
  final now = DateTime.now();
  @override
  Future<CalendarState> build() async {
    // 초기 상태 설정
    final user = await userUsecases.getCurrentUser();
    final expenseList = await expenseUsecases.fetchExpenseList(
      user!.id,
      '${now.year}-${now.month}',
    );
    Logger.debug('expenseList: $expenseList');
    return CalendarState(selectedDay: now, focusedDay: now, events: []);
  }

  /// 날짜 선택
  void selectDay(DateTime day) {
    state = AsyncValue.data(
      state.value!.copyWith(selectedDay: day, focusedDay: day),
    );
  }

  /// 포커스된 날짜 변경 (월 변경 시)
  void changeFocusedDay(DateTime day) {
    state = AsyncValue.data(state.value!.copyWith(focusedDay: day));
  }

  /// 이벤트 추가
  // void addEvent(CalendarEvent event) {
  //   final currentEvents = state.value!.events;
  //   final updatedEvents = [...currentEvents, event];

  //   state = AsyncValue.data(state.value!.copyWith(events: updatedEvents));
  // }

  /// 이벤트 삭제
  // void removeEvent(String eventId) {
  //   final currentEvents = state.value!.events;
  //   final updatedEvents = currentEvents.where((e) => e.id != eventId).toList();

  //   state = AsyncValue.data(state.value!.copyWith(events: updatedEvents));
  // }

  /// 특정 날짜의 이벤트 조회
  // List<CalendarEvent> getEventsForDay(DateTime day) {
  //   return state.value!.events.where((event) {
  //     return event.date.year == day.year &&
  //         event.date.month == day.month &&
  //         event.date.day == day.day;
  //   }).toList();
  // }

  /// 로딩 상태 설정
  // void setLoading(bool isLoading) {
  //   state = AsyncValue.data(state.value!.copyWith(isLoading: isLoading));
  // }
}
