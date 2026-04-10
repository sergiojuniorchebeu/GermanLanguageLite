import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';
import 'package:projet2/User/Widget/Navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ─────────────────────────────────────────────────────────────────────────────
// OnboardingPage — 3 slides au premier lancement
// ─────────────────────────────────────────────────────────────────────────────
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController();
  final _nameController = TextEditingController();
  int _currentPage = 0;

  static const _slides = [
    _SlideData(
      emoji: '🏥',
      title: 'Apprenez l\'allemand\nmédical',
      subtitle:
          'Conçu pour les infirmiers, étudiants et professionnels de santé qui travaillent ou souhaitent travailler en Allemagne.',
      accentColor: kBlue,
      accentLight: kBlueLight,
    ),
    _SlideData(
      emoji: '📚',
      title: '11 chapitres,\n33+ leçons',
      subtitle:
          'De l\'admission du patient à la sortie, couvrez tous les scénarios médicaux essentiels en contexte germanophone.',
      accentColor: kPurple,
      accentLight: kPurpleLight,
    ),
    _SlideData(
      emoji: '🚀',
      title: 'Commençons !',
      subtitle: 'Comment souhaitez-vous être appelé(e) ?',
      accentColor: kGreen,
      accentLight: kGreenLight,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    final name = _nameController.text.trim();
    final prefs = await SharedPreferences.getInstance();
    if (name.isNotEmpty) {
      await prefs.setString('name', name);
    }
    await prefs.setBool('isFirstLaunch', false);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const NavigationHomePage()),
    );
  }

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffold,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 20, 0),
                child: GestureDetector(
                  onTap: _finish,
                  child: Text(
                    'Passer',
                    style: AppText.bodyM.copyWith(color: kInk500),
                  ),
                ),
              ),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: _slides.length,
                itemBuilder: (context, index) =>
                    _SlidePage(slide: _slides[index], isLast: index == 2, nameController: _nameController),
              ),
            ),

            // Dots + bouton
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 36),
              child: Column(
                children: [
                  // Dots indicateurs
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _slides.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: i == _currentPage ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: i == _currentPage
                              ? _slides[_currentPage].accentColor
                              : kBorder,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  // CTA
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _slides[_currentPage].accentColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _currentPage < _slides.length - 1
                            ? 'Continuer →'
                            : 'Commencer !',
                        style: AppText.labelL.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Slide ─────────────────────────────────────────────────────────────────────
class _SlidePage extends StatelessWidget {
  final _SlideData slide;
  final bool isLast;
  final TextEditingController nameController;

  const _SlidePage({
    required this.slide,
    required this.isLast,
    required this.nameController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Emoji illustration
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: slide.accentLight,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              slide.emoji,
              style: const TextStyle(fontSize: 56),
            ),
          ),
          const SizedBox(height: 40),

          // Titre
          Text(
            slide.title,
            style: AppText.h1.copyWith(height: 1.25),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Sous-titre
          Text(
            slide.subtitle,
            style: AppText.bodyM.copyWith(color: kInk500, height: 1.6),
            textAlign: TextAlign.center,
          ),

          // Champ nom (dernière slide uniquement)
          if (isLast) ...[
            const SizedBox(height: 32),
            TextField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              style: AppText.bodyL.copyWith(color: kInk900),
              decoration: InputDecoration(
                hintText: 'Votre prénom',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 14, right: 8),
                  child: Text('👤', style: const TextStyle(fontSize: 18)),
                ),
                prefixIconConstraints:
                    const BoxConstraints(minWidth: 0, minHeight: 0),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Vous pouvez le modifier plus tard dans vos paramètres.',
              style: AppText.bodyS,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

// ── Slide Data ────────────────────────────────────────────────────────────────
class _SlideData {
  final String emoji;
  final String title;
  final String subtitle;
  final Color accentColor;
  final Color accentLight;

  const _SlideData({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.accentLight,
  });
}
