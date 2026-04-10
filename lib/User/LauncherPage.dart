import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:projet2/features/onboarding/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Widget/Navigation.dart';

class FirstLaunchHandler extends StatefulWidget {
  const FirstLaunchHandler({super.key});

  @override
  _FirstLaunchHandlerState createState() => _FirstLaunchHandlerState();
}

class _FirstLaunchHandlerState extends State<FirstLaunchHandler>
    with SingleTickerProviderStateMixin {
  bool? isFirstLaunch;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();

    // Créer l'animation avec un TickerProvider
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this, // Fournir le TickerProvider avec 'this' (qui est un TickerProvider)
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  Future<void> _checkFirstLaunch() async {
    await Future.delayed(const Duration(seconds: 2));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool firstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    if (!mounted) return;
    setState(() {
      isFirstLaunch = firstLaunch;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstLaunch == null) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF005D80), Color(0xFF01799B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image centrée
                Image.asset(
                  'assets/img/logo.png',
                  height: 150,
                ),
                const SizedBox(height: 16),

                // SpinKit
                const SpinKitChasingDots(
                  color: Colors.white,
                  size: 60.0,
                ),

                const SizedBox(height: 16),

                // Texte animé
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    'German Language Initializing...',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return isFirstLaunch! ? const OnboardingPage() : const NavigationHomePage();
  }
}
