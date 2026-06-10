/// Ntentan App Constants
/// Minimum sizes based on WCAG 2.2 and Android/iOS accessibility guidelines.
class AppSizes {
  AppSizes._();

  // ── Spacing Scale ──
  static const double space4 = 4;
  static const double space8 = 8;
  static const double space12 = 12;
  static const double space16 = 16;
  static const double space20 = 20;
  static const double space24 = 24;
  static const double space32 = 32;
  static const double space40 = 40;
  static const double space48 = 48;
  static const double space56 = 56;
  static const double space64 = 64;

  // ── Touch Targets ──
  /// Minimum touch target size per WCAG 2.2 (56dp for accessibility apps)
  static const double minTouchTarget = 56;

  /// Minimum icon size for legibility
  static const double minIconSize = 24;

  // ── Border Radii ──
  static const double radiusSmall = 8;
  static const double radiusMedium = 12;
  static const double radiusLarge = 16;
  static const double radiusXL = 20;
  static const double radiusRound = 100;

  // ── Font Sizes ──
  /// Minimum body font — accessibility standard
  static const double minBodyFont = 16;

  /// Minimum caption font size for Speech Captioning screen
  static const double minCaptionFont = 20;

  /// Large caption for arm's-length reading
  static const double largeCaptionFont = 32;

  // ── Animation Durations ──
  /// Only purposeful animations — not decorative
  static const Duration animFast = Duration(milliseconds: 150);
  static const Duration animNormal = Duration(milliseconds: 250);
  static const Duration animSlow = Duration(milliseconds: 400);

  // ── SOS ──
  static const int sosCountdownSeconds = 5;

  // ── Onboarding ──
  static const Duration splashAutoNavigate = Duration(seconds: 3);
}
