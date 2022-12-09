import 'package:flutter/material.dart';

class Styles {
  static List<BoxShadow> rhstLogoShadows = [
    const BoxShadow(
      color: Colors.white,
      offset: Offset(-8, -8),
      blurRadius: 12,
    ),
    const BoxShadow(
      color: Colors.white,
      offset: Offset(-4, -4),
      blurRadius: 8,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.25),
      offset: const Offset(3, 3),
      blurRadius: 8,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      offset: const Offset(10, 10),
      blurRadius: 15,
    ),
  ];

  static List<BoxShadow> rhstOuterShadows = [
    BoxShadow(
      color: Colors.white.withOpacity(0.6),
      offset: const Offset(-6, -6),
      blurRadius: 10,
    ),
    BoxShadow(
      color: Colors.white.withOpacity(0.6),
      offset: const Offset(-3, -3),
      blurRadius: 8,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      offset: const Offset(3, 3),
      blurRadius: 3,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      offset: const Offset(6, 6),
      blurRadius: 8,
    ),
  ];

  static List<BoxShadow> rhstButtonShadows = [
    BoxShadow(
      color: Colors.white.withOpacity(1.0),
      offset: const Offset(-6, -6),
      blurRadius: 8,
    ),
    BoxShadow(
      color: Colors.white.withOpacity(1.0),
      offset: const Offset(-3, -3),
      blurRadius: 3,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.5),
      offset: const Offset(3, 3),
      blurRadius: 3,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.4),
      offset: const Offset(6, 6),
      blurRadius: 8,
    ),
  ];

  static final BorderRadius borderRadiusInput = BorderRadius.circular(8);
  static final BorderRadius borderRadiusCard = BorderRadius.circular(15);

  static final TextStyle headline = TextStyle(
    color: RHSTColors.primary[700],
    fontWeight: FontWeight.w600,
    fontSize: 30,
  );

  static const TextStyle subHeadline = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontSize: 26,
  );

  static final TextStyle paragraph = TextStyle(
    color: RHSTColors.neutral[500],
    fontSize: 16,
  );

  static final TextStyle light = TextStyle(
    color: RHSTColors.neutral[400],
    fontWeight: FontWeight.normal,
  );
}

class RHSTColors {
  static MaterialColor neutral = const MaterialColor(0xFF94A3B8, _neutral);
  static const Map<int, Color> _neutral = {
    50: Color(0xFFF8FAFC),
    100: Color(0xFFF1F5F9),
    200: Color(0xFFE2E8F0),
    300: Color(0xFFCBD5E1),
    400: Color(0xFF94A3B8),
    500: Color(0xFF64748B),
    600: Color(0xFF475569),
    700: Color(0xFF334155),
    800: Color(0xFF1E293B),
    900: Color(0xFF0F172A),
  };

  static MaterialColor primary = const MaterialColor(0xFFE52E32, _primary);
  static const Map<int, Color> _primary = {
    100: Color(0xFFFFB2B4),
    300: Color(0xFFFF6669),
    500: Color(0xFFE52E32),
    700: Color(0xFFC40004),
    900: Color(0xFF8C0003),
  };

  static MaterialColor success = const MaterialColor(0xFF10B981, _success);
  static const Map<int, Color> _success = {
    100: Color(0xFFEDFDF5),
    300: Color(0xFF6EE7B7),
    500: Color(0xFF10B981),
    700: Color(0xFF047857),
    900: Color(0xFF064E3B),
  };

  static MaterialColor error = const MaterialColor(0xFFEF4444, _error);
  static const Map<int, Color> _error = {
    100: Color(0xFFFEF2F2),
    300: Color(0xFFF79494),
    500: Color(0xFFEF4444),
    700: Color(0xFFB91C1C),
    900: Color(0xFF7F1D1D),
  };
}
