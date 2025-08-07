import 'package:flutter/material.dart';

class AppColors {
  // Palette (private, 디자인 시스템 토큰과 1:1 매칭)
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _black = Color(0xFF000000);
  static const Color _mint = Color(0xFF00DDEC);

  static const Color _neutral100 = Color(0xFFF8F9FB);
  static const Color _neutral300 = Color(0xFFDFE2E5);
  static const Color _neutral400 = Color(0xFFCFD4DA);
  static const Color _neutral600 = Color(0xFF6B747E);
  static const Color _neutral800 = Color(0xFF353A40);
  static const Color _neutral900 = Color(0xFF202428);

  static const Color _blue200 = Color(0xFFD7F6FF); // 20% opacity
  static const Color _blue400 = Color(0xFF42A1FF);
  static const Color _blue500 = Color(0xFF1389FF);

  static const Color _green500 = Color(0xFF4BC849);
  static const Color _green600 = Color(0xFF44B642);

  static const Color _orange500 = Color(0xFFFC8A19);

  static const Color _red500 = Color(0xFFEF4444);

  static const Color _gray50 = Color(0xFFF8F9FB);

  // Palette with opacity variants
  static const Color _neutral800_66 = Color(0xA8353A40); // 66% opacity
  static const Color _neutral800_37 = Color(0x5E353A40); // 37% opacity
  static const Color _neutral800_20 = Color(0x33353A40); // 20% opacity
  static const Color _neutral800_12 = Color(0x1F353A40); // 12% opacity
  static const Color _neutral600_20 = Color(0x336B747E); // 20% opacity
  static const Color _neutral400_08 = Color(0x14CFD4DA); // 8% opacity
  static const Color _black_40 = Color(0x66000000); // 40% opacity
  static const Color _black_50 = Color(0x80000000); // 50% opacity
  static const Color _white_40 = Color(0x66FFFFFF); // 40% opacity

  // Semantic Colors
  // Primary
  static const Color primary = _mint;

  // Label
  static const Color labelHighlight = _neutral900;
  static const Color labelPrimary = _neutral800;
  static const Color labelSecondary = _neutral800_66;
  static const Color labelTertiary = _neutral800_37;
  static const Color labelCaption = _neutral800_20;
  static const Color labelDisabled = _neutral800_12;
  static const Color labelLink = _blue400;
  static const Color labelInverse = _white;

  // Status
  static const Color statusPositive = _green500;
  static const Color statusWarning = _orange500;
  static const Color statusError = _red500;
  static const Color statusInformative = _blue500;

  // Background
  static const Color backgroundDefault = _white;
  static const Color backgroundGray = _gray50;
  static const Color backgroundAlternative = _neutral100;
  static const Color backgroundAppleSignInButton = _black;
  static const Color backgroundGoogleSignInButton = _neutral100;
  static const Color backgroundSelectedCalendar = _blue200;
  static const Color backgroundTodayCalendar = _blue200; // 오늘 날짜 배경색

  // Component / Fill
  static const Color componentFillPrimary = _white;
  static const Color componentFillSecondary = _neutral100;
  static const Color componentFillAlternative = _neutral400_08;

  // Component / Line
  static const Color componentLineDefault = _neutral600_20;
  static const Color componentLineAlternative = _neutral300;
  static const Color componentLineStrong = _neutral800;

  // Text
  static const Color textPrimary = _neutral800; // 기본 본문 텍스트
  static const Color textSecondary = _neutral600; // 서브/보조 텍스트
  static const Color textDisabled = _neutral400; // 비활성 텍스트
  static const Color textInverse = _white; // 어두운 배경 위 텍스트
  static const Color textLink = _blue500; // 링크 텍스트
  static const Color textError = _red500; // 에러 텍스트
  static const Color textSuccess = _green600; // 성공 텍스트

  // Calendar specific colors
  static const Color calendarTodayBackground = _blue200; // 오늘 날짜 배경
  static const Color calendarIncome = _green500; // 수입 색상
  static const Color calendarExpense = _red500; // 지출 색상
  static const Color calendarSaturday = _blue500; // 토요일 색상
  static const Color calendarSunday = _red500; // 일요일 색상
  static const Color calendarOutsideDate = _neutral400; // 이전/다음 달 날짜

  // Modal이나 Alert의 배경 색상
  static const Color dimmer = _black_40;
  static const Color overlay = _black_50;
  static const Color whiteDimmer = _white_40;
}
