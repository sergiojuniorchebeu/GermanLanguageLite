import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:projet2/User/Widget/Navigation.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';
import 'package:projet2/features/onboarding/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstLaunchHandler extends StatefulWidget {
  const FirstLaunchHandler({super.key});

  @override
  State<FirstLaunchHandler> createState() => _FirstLaunchHandlerState();
}

class _FirstLaunchHandlerState extends State<FirstLaunchHandler>
    with SingleTickerProviderStateMixin {
  bool? isFirstLaunch;
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 950),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _checkFirstLaunch() async {
    await Future.delayed(const Duration(seconds: 2));
    final prefs = await SharedPreferences.getInstance();
    final firstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    if (!mounted) return;
    setState(() => isFirstLaunch = firstLaunch);
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstLaunch == null) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF130F0D), Color(0xFF24120F), kCoral],
            ),
          ),
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const _SplashLogo(),
                  const SizedBox(height: 26),
                  Text(
                    'German Language Lite',
                    style: AppText.h2.copyWith(
                      color: Colors.white,
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Medical German, redesigned.',
                    style: AppText.bodyM.copyWith(
                      color: Colors.white.withValues(alpha: 0.72),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const SpinKitThreeBounce(
                    color: kFlagGold,
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return isFirstLaunch! ? const OnboardingPage() : const NavigationHomePage();
  }
}

class _SplashLogo extends StatelessWidget {
  const _SplashLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 122,
      height: 122,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(34),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 28,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 66,
              height: 66,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
              ),
              clipBehavior: Clip.antiAlias,
              child: const Column(
                children: [
                  Expanded(child: ColoredBox(color: kFlagBlack)),
                  Expanded(child: ColoredBox(color: kFlagRed)),
                  Expanded(child: ColoredBox(color: kFlagGold)),
                ],
              ),
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'G',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
