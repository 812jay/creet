import 'package:creet/lib/presentation/widgets/common/app_bottom_nav_bar.dart';
import 'package:creet/lib/presentation/views/calendar/calendar_view.dart';
import 'package:creet/lib/presentation/views/home_view.dart';
import 'package:creet/lib/presentation/views/setting_view.dart';
import 'package:flutter/material.dart';

import 'chart_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0; // "내 정보" 탭이 기본

  final List<Widget> _screens = [
    HomeView(),
    CalendarView(),
    ChartView(),
    SettingView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
