import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MNPColors {
  static const Color gold = Color(0xFFC9A96E);
  static const Color goldDark = Color(0xFFB8860B);
  static const Color ivory = Color(0xFFFAF7F2);
  static const Color ivoryDark = Color(0xFFF0EBE3);
  static const Color charcoal = Color(0xFF1A1A1A);
  static const Color charcoalMid = Color(0xFF2C2C2C);
  static const Color beige = Color(0xFFE8DDD0);
  static const Color warmGrey = Color(0xFF8A8A8A);
  static const Color lightGrey = Color(0xFFD4CFC9);
  static const Color white = Color(0xFFFFFFFF);
  static const Color darkOverlay = Color(0xAA0A0A0A);
  static const Color sectionDark = Color(0xFF111111);
}

class MNPTextStyles {
  static TextStyle displayLarge(BuildContext context) =>
      GoogleFonts.cormorantGaramond(
        fontSize: _responsive(context, 72, 52, 38),
        fontWeight: FontWeight.w300,
        color: MNPColors.white,
        height: 1.1,
        letterSpacing: 1.5,
      );

  static TextStyle displayMedium(BuildContext context) =>
      GoogleFonts.cormorantGaramond(
        fontSize: _responsive(context, 52, 40, 32),
        fontWeight: FontWeight.w300,
        color: MNPColors.charcoal,
        height: 1.2,
        letterSpacing: 1.0,
      );

  static TextStyle displaySmall(BuildContext context) =>
      GoogleFonts.cormorantGaramond(
        fontSize: _responsive(context, 38, 32, 26),
        fontWeight: FontWeight.w400,
        color: MNPColors.charcoal,
        height: 1.3,
        letterSpacing: 0.8,
      );

  static TextStyle headlineLarge(BuildContext context) =>
      GoogleFonts.cormorantGaramond(
        fontSize: _responsive(context, 28, 24, 20),
        fontWeight: FontWeight.w500,
        color: MNPColors.charcoal,
        height: 1.4,
        letterSpacing: 0.5,
      );

  static TextStyle bodyLarge(BuildContext context) =>
      GoogleFonts.lato(
        fontSize: _responsive(context, 16, 15, 14),
        fontWeight: FontWeight.w300,
        color: MNPColors.warmGrey,
        height: 1.8,
        letterSpacing: 0.3,
      );

  static TextStyle bodyMedium(BuildContext context) =>
      GoogleFonts.lato(
        fontSize: _responsive(context, 14, 13, 13),
        fontWeight: FontWeight.w400,
        color: MNPColors.warmGrey,
        height: 1.7,
        letterSpacing: 0.2,
      );

  static TextStyle labelLarge(BuildContext context) =>
      GoogleFonts.lato(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: MNPColors.gold,
        letterSpacing: 3.0,
      );

  static TextStyle navItem(BuildContext context) =>
      GoogleFonts.lato(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 2.5,
        color: MNPColors.charcoal,
      );

  static TextStyle italic(BuildContext context) =>
      GoogleFonts.cormorantGaramond(
        fontSize: _responsive(context, 72, 52, 38),
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.italic,
        color: MNPColors.gold,
        height: 1.1,
        letterSpacing: 1.5,
      );

  static TextStyle italicMedium(BuildContext context) =>
      GoogleFonts.cormorantGaramond(
        fontSize: _responsive(context, 52, 40, 32),
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.italic,
        color: MNPColors.gold,
        height: 1.2,
        letterSpacing: 1.0,
      );

  static double _responsive(BuildContext ctx, double d, double t, double m) {
    final w = MediaQuery.of(ctx).size.width;
    if (w >= 1024) return d;
    if (w >= 768) return t;
    return m;
  }
}

class MNPDimensions {
  static double horizontalPadding(BuildContext ctx) {
    final w = MediaQuery.of(ctx).size.width;
    if (w >= 1200) return (w - 1140) / 2;
    if (w >= 1024) return 60;
    if (w >= 768) return 40;
    return 24;
  }

  static bool isDesktop(BuildContext ctx) =>
      MediaQuery.of(ctx).size.width >= 1024;

  static bool isTablet(BuildContext ctx) {
    final w = MediaQuery.of(ctx).size.width;
    return w >= 768 && w < 1024;
  }

  static bool isMobile(BuildContext ctx) =>
      MediaQuery.of(ctx).size.width < 768;
}
