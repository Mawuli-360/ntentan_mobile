import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Ntentan Theme
/// - Atkinson Hyperlegible for body (designed by Braille Institute for low-vision)
/// - Lexend Deca for headings (reduces visual stress, 25% faster reading)
/// - High-contrast dark theme by default
/// - Minimum 16sp body, 56dp touch targets
class AppTheme {
  AppTheme._();

  static const String _headingFamily = 'LexendDeca';
  static const String _bodyFamily = 'AtkinsonHyperlegible';

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.surface,
        primary: AppColors.vi,
        secondary: AppColors.vi,
        tertiary: AppColors.shared,
        error: AppColors.error,
        onSurface: AppColors.textPrimary,
        onPrimary: AppColors.bg,
        onSecondary: AppColors.bg,
        onError: AppColors.textOnDark,
      ),
      textTheme: _textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.bg,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: _headingFont(20, FontWeight.w700),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.vi,
        unselectedItemColor: AppColors.textMuted,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true, // Always show text labels
        selectedLabelStyle:
            TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 12),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.vi,
          foregroundColor: AppColors.bg,
          minimumSize: const Size(double.infinity, 56), // 56dp min
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: _headingFont(16, FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          minimumSize: const Size(double.infinity, 56),
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: _headingFont(16, FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface2,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.vi, width: 2),
        ),
        labelStyle: _bodyFont(16, FontWeight.w400, AppColors.textSecondary),
        hintStyle: _bodyFont(16, FontWeight.w400, AppColors.textMuted),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.vi;
          return AppColors.textMuted;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.viBg;
          return AppColors.surface2;
        }),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surface2,
        selectedColor: AppColors.viBg,
        labelStyle: _bodyFont(14, FontWeight.w500, AppColors.textPrimary),
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surface2,
        contentTextStyle: _bodyFont(14, FontWeight.w400, AppColors.textPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// True Black mode for users needing maximum contrast
  static ThemeData get trueBlack {
    return dark.copyWith(
      scaffoldBackgroundColor: AppColors.trueBg,
      colorScheme: dark.colorScheme.copyWith(
        surface: AppColors.trueSurface,
      ),
      cardTheme: dark.cardTheme.copyWith(
        color: AppColors.trueSurface,
      ),
      appBarTheme: dark.appBarTheme.copyWith(
        backgroundColor: AppColors.trueBg,
      ),
    );
  }

  static ThemeData get highContrast => trueBlack;

  // ── Typography ──

  static TextTheme get _textTheme {
    return TextTheme(
      // Headings — Lexend Deca
      displayLarge: _headingFont(40, FontWeight.w800),
      displayMedium: _headingFont(32, FontWeight.w700),
      displaySmall: _headingFont(28, FontWeight.w700),
      headlineLarge: _headingFont(24, FontWeight.w700),
      headlineMedium: _headingFont(20, FontWeight.w700),
      headlineSmall: _headingFont(18, FontWeight.w600),
      // Titles — Lexend Deca
      titleLarge: _headingFont(18, FontWeight.w700),
      titleMedium: _headingFont(16, FontWeight.w600),
      titleSmall: _headingFont(14, FontWeight.w600),
      // Body — Atkinson Hyperlegible (16sp minimum)
      bodyLarge: _bodyFont(18, FontWeight.w400, AppColors.textPrimary),
      bodyMedium: _bodyFont(16, FontWeight.w400, AppColors.textPrimary),
      bodySmall: _bodyFont(14, FontWeight.w400, AppColors.textSecondary),
      // Labels
      labelLarge: _bodyFont(16, FontWeight.w600, AppColors.textPrimary),
      labelMedium: _bodyFont(14, FontWeight.w500, AppColors.textPrimary),
      labelSmall: _bodyFont(12, FontWeight.w500, AppColors.textSecondary),
    );
  }

  static TextStyle _headingFont(double size, FontWeight weight) {
    return TextStyle(
      fontFamily: _headingFamily,
      fontSize: size,
      fontWeight: weight,
      color: AppColors.textPrimary,
      height: 1.3,
    );
  }

  static TextStyle _bodyFont(double size, FontWeight weight, Color color) {
    return TextStyle(
      fontFamily: _bodyFamily,
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: 1.6, // Generous leading for low-vision line tracking
    );
  }
}
