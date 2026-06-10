import 'package:flutter/material.dart';

/// Ntentan Color Palette
/// Designed for WCAG AAA contrast on dark surfaces.
class AppColors {
  AppColors._();

  // ── Backgrounds ──
  static const Color bg = Color(0xFF0A0F1A);
  static const Color surface = Color(0xFF111827);
  static const Color surface2 = Color(0xFF1A2235);
  static const Color surfaceLight = Color(0xFF243049);

  // ── True Black Mode ──
  static const Color trueBg = Color(0xFF000000);
  static const Color trueSurface = Color(0xFF0A0A0A);
  static const Color trueSurface2 = Color(0xFF141414);

  // ── Light Mode Backgrounds ──
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurface2 = Color(0xFFF1F5F9);

  // ── Text (Dark Surface) ──
  static const Color textPrimary = Color(0xFFE8EDF5);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF6B7A99);
  static const Color textOnDark = Color(0xFFFFFFFF);

  // ── Text (Light Surface) ──
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightTextMuted = Color(0xFF64748B);
  static const Color textOnLight = Color(0xFF000000);

  // ── Track Colors ──
  /// Visually Impaired track — Teal
  static const Color vi = Color(0xFF00D4AA);
  static const Color viBg = Color(0x1F00D4AA); // 12%
  static const Color viBorder = Color(0x3300D4AA); // 20%
  static const Color viText = Color(0xFFB6FFF2);

  /// Shared/Common — Amber (FBBF24 for text, F59E0B decorative)
  static const Color shared = Color(0xFFFBBF24);
  static const Color sharedDecorative = Color(0xFFF59E0B);
  static const Color sharedBg = Color(0x1FF59E0B);
  static const Color sharedBorder = Color(0x33F59E0B);
  static const Color sharedText = Color(0xFFFFF6CC);

  /// AI — Blue
  static const Color ai = Color(0xFF3B82F6);
  static const Color aiBg = Color(0x1F3B82F6);
  static const Color aiBorder = Color(0x333B82F6);
  static const Color aiText = Color(0xFFDCEBFF);

  /// Emergency — Red
  static const Color emergency = Color(0xFFEF4444);
  static const Color emergencyBg = Color(0x1FEF4444);
  static const Color emergencyBorder = Color(0x33EF4444);
  static const Color emergencyText = Color(0xFFFFE2E2);

  // ── Borders ──
  static const Color border = Color(0x12FFFFFF); // 7% white
  static const Color borderLight = Color(0x1FFFFFFF); // 12% white
  static const Color borderColor = border;
  static const Color black = Color(0xFF000000);
  static const MaterialColor gray = Colors.grey;

  // ── Status ──
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFFBBF24);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  /// Returns the appropriate color set for a given context
  static Color trackColor(TrackType type) {
    switch (type) {
      case TrackType.vi:
        return vi;
      case TrackType.shared:
        return shared;
      case TrackType.ai:
        return ai;
      case TrackType.emergency:
        return emergency;
    }
  }

  static Color trackBg(TrackType type) {
    switch (type) {
      case TrackType.vi:
        return viBg;
      case TrackType.shared:
        return sharedBg;
      case TrackType.ai:
        return aiBg;
      case TrackType.emergency:
        return emergencyBg;
    }
  }

  static Color trackBorder(TrackType type) {
    switch (type) {
      case TrackType.vi:
        return viBorder;
      case TrackType.shared:
        return sharedBorder;
      case TrackType.ai:
        return aiBorder;
      case TrackType.emergency:
        return emergencyBorder;
    }
  }

  static Color trackText(TrackType type) {
    switch (type) {
      case TrackType.vi:
        return viText;
      case TrackType.shared:
        return sharedText;
      case TrackType.ai:
        return aiText;
      case TrackType.emergency:
        return emergencyText;
    }
  }
}

enum TrackType { vi, shared, ai, emergency }
