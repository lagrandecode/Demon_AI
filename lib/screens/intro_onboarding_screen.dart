import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:video_player/video_player.dart';

import '../constants/app_assets.dart';
import '../constants/app_constants.dart';
import '../widgets/app_logo.dart';
import 'second_onboarding_screen.dart';

class IntroOnboardingScreen extends StatefulWidget {
  const IntroOnboardingScreen({super.key});

  @override
  State<IntroOnboardingScreen> createState() => _IntroOnboardingScreenState();
}

class _IntroOnboardingScreenState extends State<IntroOnboardingScreen> {
  late final VideoPlayerController _controller;
  bool _initialized = false;
  Object? _error;
  Timer? _advanceTimer;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(AppAssets.introVideo);
    _scheduleAdvance();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      await _controller.initialize();
      await _controller.setVolume(0);
      await _controller.setLooping(false);
      await _controller.play();
      if (!mounted) return;
      setState(() => _initialized = true);
      FlutterNativeSplash.remove();
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e);
      FlutterNativeSplash.remove();
    }
  }

  void _scheduleAdvance() {
    _advanceTimer?.cancel();
    _advanceTimer = Timer(AppConstants.introOnboardingDuration, _goToNextScreen);
  }

  void _goToNextScreen() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const SecondOnboardingScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _advanceTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (_initialized)
              _IntroVideo(player: _controller)
            else if (_error != null)
              _IntroLoading(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Could not load intro video.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                ),
              )
            else
              const _IntroLoading(),
          ],
        ),
      ),
    );
  }
}

class _IntroVideo extends StatelessWidget {
  const _IntroVideo({required this.player});

  final VideoPlayerController player;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        width: player.value.size.width,
        height: player.value.size.height,
        child: VideoPlayer(player),
      ),
    );
  }
}

class _IntroLoading extends StatelessWidget {
  const _IntroLoading({this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppLogo(),
            if (child != null) ...[
              const SizedBox(height: 24),
              child!,
            ],
          ],
        ),
      ),
    );
  }
}
