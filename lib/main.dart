import 'package:flutter/material.dart';

import 'constants/app_colors.dart';
import 'constants/app_constants.dart';
import 'screens/intro_onboarding_screen.dart';
import 'widgets/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DemonAiApp());
}

class DemonAiApp extends StatelessWidget {
  const DemonAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.launchBackground,
      ),
      builder: (context, child) {
        return ColoredBox(
          color: AppColors.launchBackground,
          child: child ?? const SplashScreen(),
        );
      },
      home: const IntroOnboardingScreen(),
    );
  }
}
