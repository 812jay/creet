import 'package:flutter/material.dart';

class AppColors {
  // Palette (private, 디자인 시스템 토큰과 1:1 매칭)
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _black = Color(0xFF000000);
  static const Color _mint = Color(0xFF00DDEC);

  static const Color _neutral100 = Color(0xFFF8F9FB);
  static const Color _neutral200 = Color(0xFFE8EBEE);
  static const Color _neutral300 = Color(0xFFDFE2E5);
  static const Color _neutral400 = Color(0xFFCFD4DA);
  static const Color _neutral500 = Color(0xFFACB4BD);
  static const Color _neutral600 = Color(0xFF6B747E);
  static const Color _neutral700 = Color(0xFF495058);
  static const Color _neutral800 = Color(0xFF353A40);
  static const Color _neutral900 = Color(0xFF202428);

  static const Color _primary50 = Color(0xFFE8F9FF);
  static const Color _primary100 = Color(0xFFB8ECFE);
  static const Color _primary200 = Color(0xFF95E3FE);
  static const Color _primary300 = Color(0xFF65D7FD);
  static const Color _primary400 = Color(0xFF47CFFD);
  static const Color _primary500 = Color(0xFF19C3FC);
  static const Color _primary600 = Color(0xFF17B1E5);
  static const Color _primary700 = Color(0xFF128AB3);
  static const Color _primary800 = Color(0xFF0E6B8B);
  static const Color _primary900 = Color(0xFF0B526A);

  static const Color _blue50 = Color(0xFFEE7F3FF);
  static const Color _blue100 = Color(0xFFB6DAFF);
  static const Color _blue200 = Color(0xFF92C9FF);
  static const Color _blue300 = Color(0xFF61B0FF);
  static const Color _blue400 = Color(0xFF42A1FF);
  static const Color _blue500 = Color(0xFF1389FF);
  static const Color _blue600 = Color(0xFF117DE8);
  static const Color _blue700 = Color(0xFF0D61B5);
  static const Color _blue800 = Color(0xFF0A4B8C);
  static const Color _blue900 = Color(0xFF083A6B);

  static const Color _green50 = Color(0xFFEDFAED);
  static const Color _green100 = Color(0xFFC7EEC7);
  static const Color _green200 = Color(0xFFACE6AB);
  static const Color _green300 = Color(0xFF86DA85);
  static const Color _green400 = Color(0xFF6FD36D);
  static const Color _green500 = Color(0xFF4BC849);
  static const Color _green600 = Color(0xFF44B642);
  static const Color _green700 = Color(0xFF358E34);
  static const Color _green800 = Color(0xFF296E28);
  static const Color _green900 = Color(0xFF20541F);

  static const Color _orange50 = Color(0xFFFFF3E8);
  static const Color _orange100 = Color(0xFFFEDBB8);
  static const Color _orange200 = Color(0xFFFEC995);
  static const Color _orange300 = Color(0xFFFDB165);
  static const Color _orange400 = Color(0xFFFDA147);
  static const Color _orange500 = Color(0xFFFC8A19);
  static const Color _orange600 = Color(0xFFE57E17);
  static const Color _orange700 = Color(0xFFB36212);
  static const Color _orange800 = Color(0xFF8B4C0E);
  static const Color _orange900 = Color(0xFF6A3A0B);

  static const Color _red50 = Color(0xFFFDECEC);
  static const Color _red100 = Color(0xFFFAC5C5);
  static const Color _red200 = Color(0xFFF8A9A9);
  static const Color _red300 = Color(0xFFF48282);
  static const Color _red400 = Color(0xFFF26969);
  static const Color _red500 = Color(0xFFEF4444);
  static const Color _red600 = Color(0xFFD93E3E);
  static const Color _red700 = Color(0xFFAA3030);
  static const Color _red800 = Color(0xFF832525);
  static const Color _red900 = Color(0xFF641D1D);

  // Semantic Colors
  // Primary
  static const Color primary = _primary500;

  // Label
  static const Color labelHighlight = _neutral900;
  static const Color labelPrimary = _neutral800;
  static Color labelSecondary = _neutral800.withOpacity(0.66); // 66% opacity
  static Color labelTertiary = _neutral800.withOpacity(0.37); // 37% opacity
  static Color labelCaption = _neutral800.withOpacity(0.20); // 20% opacity
  static Color labelDisabled = _neutral800.withOpacity(0.12); // 12% opacity
  static const Color labelLink = _blue400;
  static const Color labelInverse = _white;

  // Status
  static const Color statusPositive = _green500;
  static const Color statusWarning = _orange500;
  static const Color statusError = _red500;
  static const Color statusInformative = _blue500;

  // Background
  static const Color backgroundDefault = _white;
  static const Color backgroundAlternative = _neutral100;
  static const Color backgroundAppleSignInButton = _black;
  static const Color backgroundGoogleSignInButton = _neutral100;

  // Component / Fill
  static const Color componentFillPrimary = _white;
  static const Color componentFillSecondary = _neutral100;
  static Color componentFillAlternative = _neutral400.withOpacity(
    0.08,
  ); // with opacity 8% (Color(0x148CB4BD))

  // Component / Line
  static Color componentLineDefault = _neutral600.withOpacity(
    0.20,
  ); // with opacity 20% (Color(0x336B747E))
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

  // Modal이나 Alert의 배경 색상
  static Color dimmer = _black.withOpacity(0.40); // 40% black
  static Color overlay = _black.withOpacity(0.50); // 50% black
  static Color whiteDimmer = _white.withOpacity(0.40); // 40% white
}
