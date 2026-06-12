import 'package:flutter/material.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import 'app_logo.dart';

/// Full-screen Flutter launch view (replaces blank screen while app loads).
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, this.child});

  final Widget? child;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage(AppAssets.logo), context);
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.launchBackground,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppLogo(size: AppConstants.splashLogoSize),
            if (widget.child != null) ...[
              const SizedBox(height: 24),
              widget.child!,
            ],
          ],
        ),
      ),
    );
  }
}
