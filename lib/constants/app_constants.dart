/// App-wide constants (durations, keys, labels).
abstract final class AppConstants {
  static const appName = 'Demon AI';

  /// In-app logo width/height (onboarding, headers).
  static const double logoSize = 120;

  /// Launch / loading screen — [AppAssets.logo].
  static const double splashLogoSize = 120;

  /// First onboarding (intro video) before auto-advance.
  static const Duration introOnboardingDuration = Duration(seconds: 5);
}
