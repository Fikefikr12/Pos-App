import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AppTheme {
  // 🌞 Light Theme
  static final lightMode = ShadThemeData(
    brightness: Brightness.light,
    colorScheme: ShadColorScheme(
      background: Colors.grey.shade200,
      foreground: const Color(0xFF111827),
      card: Colors.white,
      cardForeground: const Color(0xFF111827),
      popover: Colors.white,
      popoverForeground: const Color(0xFF111827),
      primary: Colors.white,
      primaryForeground: Colors.black,
      secondary: const Color(0xFFE5E7EB),
      secondaryForeground: Colors.white,
      muted: const Color.fromARGB(255, 97, 97, 97),
      mutedForeground: Colors.grey.shade50,
      accent: Colors.grey.shade100,
      accentForeground: Colors.black38,
      destructive: const Color(0xFFDC2626),
      destructiveForeground: Colors.white,
      border: const Color(0xFFD1D5DB),
      input: Colors.grey.shade300,
      ring: Colors.white12,
      selection: const Color(0xFFDBEAFE),
    ),

    // 🖋️ Typography
    // textTheme: const ShadTextTheme(
    //   fontFamily: 'Poppins',
    //   baseSize: 14,
    // ),

    // // 🟣 Shape & Spacing
    // radius: 12.0,
    // spacing: 8.0,

    // 🌈 Custom extensions
    extensions: [CustomColors.light],
  );

  // 🌙 Dark Theme
  static final darkMode = ShadThemeData(
    brightness: Brightness.dark,
    colorScheme: ShadColorScheme(
      background: const Color(0xFF111827),
      foreground: const Color(0xFFF9FAFB),
      card: const Color(0xFF1F2937),
      cardForeground: Colors.black,
      popover: const Color(0xFF1F2937),
      popoverForeground: const Color(0xFFF9FAFB),
      primary: Colors.grey.shade700,
      primaryForeground: Colors.white,
      secondary: const Color(0xFF374151),
      secondaryForeground: Colors.white,
      muted: const Color.fromARGB(255, 97, 97, 97),
      mutedForeground: const Color(0xFF1F2937),
      accent: const Color(0xFF1F2937),
      accentForeground: Colors.white60,
      destructive: const Color(0xFFEF4444),
      destructiveForeground: Colors.white,
      border: const Color(0xFF4B5563),
      input: Colors.black38,
      ring: Colors.black38,
      selection: const Color(0xFF1E40AF),
    ),

    extensions: [CustomColors.dark],
  );
}

/// 🌈 Custom Color Extensions
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  final Color success;
  final Color warning;
  final Color brand;
  // final Color selectedbackground;

  const CustomColors({
    required this.success,
    required this.warning,
    required this.brand,
  });

  // Light mode palette
  static const light = CustomColors(
    success: Color(0xFFF59E0B),
    warning: Color(0xFFF59E0B),
    brand: Colors.white24,
    //selectedbackground:Colors.white
  );

  // Dark mode palette
  static const dark = CustomColors(
    success: Colors.grey,
    warning: Color(0xFFD97706),
    brand: Colors.black45,
    //selectedbackground:Colors.black12
  );

  @override
  CustomColors copyWith({Color? success, Color? warning, Color? brand}) {
    return CustomColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      brand: brand ?? this.brand,
      // selectedbackground:selectedbackground ?? this.
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      brand: Color.lerp(brand, other.brand, t)!,
    );
  }
}
