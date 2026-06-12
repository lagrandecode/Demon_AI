import 'package:flutter/material.dart';

import '../constants/app_assets.dart';
import '../constants/app_constants.dart';

/// Branded logo at a consistent size across onboarding and headers.
class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size = AppConstants.logoSize,
  }) : asset = AppAssets.logo;

  final double size;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
