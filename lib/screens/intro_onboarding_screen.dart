import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../widgets/splash_screen.dart';
import 'second_onboarding_screen.dart';

class IntroOnboardingScreen extends StatefulWidget {
  const IntroOnboardingScreen({super.key});

  @override
  State<IntroOnboardingScreen> createState() => _IntroOnboardingScreenState();
}

class _IntroOnboardingScreenState extends State<IntroOnboardingScreen> {
  late final VideoPlayerController _controller;
  bool _videoVisible = false;
  Object? _error;
  Timer? _advanceTimer;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(AppAssets.introVideo);
    _controller.addListener(_onVideoTick);
    _scheduleAdvance();
    _initializeVideo();
  }

  void _onVideoTick() {
    if (_videoVisible || !_controller.value.isInitialized) return;
    final playing = _controller.value.isPlaying;
    final hasFrame = _controller.value.position > Duration.zero;
    if (playing && hasFrame && mounted) {
      setState(() => _videoVisible = true);
    }
  }

  Future<void> _initializeVideo() async {
    try {
      await _controller.initialize();
      await _controller.setVolume(0);
      await _controller.setLooping(false);
      await _controller.play();
      // Fallback if position listener does not fire (some devices).
      Future<void>.delayed(const Duration(milliseconds: 400), () {
        if (mounted && !_videoVisible && _controller.value.isInitialized) {
          setState(() => _videoVisible = true);
        }
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e);
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
    _controller.removeListener(_onVideoTick);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.launchBackground,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (_videoVisible)
              ColoredBox(
                color: Colors.black,
                child: _IntroVideo(player: _controller),
              )
            else
              SplashScreen(
                child: _error != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Could not load intro video.',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white70,
                                  ),
                        ),
                      )
                    : null,
              ),
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
