import 'package:flutter/material.dart';

import '../constants/app_assets.dart';
import '../constants/app_constants.dart';

/// Branded logo at a consistent size across splash, onboarding, and headers.
class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size = AppConstants.logoSize,
    this.useSplashAsset = false,
  });

  final double size;
  final bool useSplashAsset;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      useSplashAsset ? AppAssets.logoSplash : AppAssets.logo,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
