/// App-wide constants (durations, keys, labels).
abstract final class AppConstants {
  static const appName = 'Demon AI';

  /// In-app logo width/height (splash loading, onboarding, headers).
  static const double logoSize = 120;

  /// First onboarding (intro video) before auto-advance.
  static const Duration introOnboardingDuration = Duration(seconds: 5);
}
