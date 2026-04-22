import 'package:flutter/material.dart';
import 'package:projet2/User/Widget/Navigation.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      title: 'Allemand medical\nplus net',
      subtitle:
          'Une interface plus premium, plus claire et plus proche des apps mobiles de langue actuelles.',
      kicker: 'Palette drapeau allemand',
      accent: kBlue,
    ),
    _SlideData(
      title: 'Lecons, vocabulaire\net situations',
      subtitle:
          'Les cartes, les sections et les chapitres sont organises pour une lecture plus rapide et plus moderne.',
      kicker: 'Rythme visuel plus editorial',
      accent: kGreen,
    ),
    _SlideData(
      title: 'Commencer avec\nvotre prenom',
      subtitle: 'Comment souhaitez-vous etre appele dans l application ?',
      kicker: 'Configuration rapide',
      accent: kPeach,
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
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
      );
      return;
    }
    _finish();
  }

  @override
  Widget build(BuildContext context) {
    final slide = _slides[_currentPage];

    return Scaffold(
      backgroundColor: kScaffold,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: kSurface,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: kBorder),
                    ),
                    child: Text(
                      'German Language Lite',
                      style: AppText.caption.copyWith(
                        color: kInk900,
                        fontSize: 10.4,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _finish,
                    child: Text(
                      'Passer',
                      style: AppText.labelM.copyWith(color: kInk600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemCount: _slides.length,
                  itemBuilder: (context, index) {
                    return _SlidePage(
                      slide: _slides[index],
                      isLast: index == _slides.length - 1,
                      nameController: _nameController,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _slides.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 240),
                    curve: Curves.easeOut,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: index == _currentPage ? 28 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: index == _currentPage ? slide.accent : kInk300,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: slide.accent,
                    foregroundColor:
                        slide.accent == kPeach ? kInk900 : Colors.white,
                  ),
                  child: Text(
                    _currentPage == _slides.length - 1
                        ? 'Entrer dans l app'
                        : 'Continuer',
                    style: AppText.labelL.copyWith(
                      color: slide.accent == kPeach ? kInk900 : Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: kSurface,
              borderRadius: BorderRadius.circular(34),
              border: Border.all(color: kBorder),
              boxShadow: const [
                BoxShadow(
                  color: kShadow,
                  blurRadius: 28,
                  offset: Offset(0, 16),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  slide.kicker,
                  style: AppText.caption.copyWith(
                    color: slide.accent,
                    fontSize: 10.6,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                const _OnboardingHero(),
                const SizedBox(height: 24),
                Text(slide.title, style: AppText.h1.copyWith(fontSize: 31)),
                const SizedBox(height: 12),
                Text(
                  slide.subtitle,
                  style: AppText.bodyL.copyWith(color: kInk600, height: 1.6),
                ),
                if (isLast) ...[
                  const SizedBox(height: 24),
                  TextField(
                    controller: nameController,
                    textCapitalization: TextCapitalization.words,
                    style: AppText.bodyL.copyWith(color: kInk900),
                    decoration: InputDecoration(
                      hintText: 'Votre prenom',
                      prefixIcon: Container(
                        margin: const EdgeInsets.only(left: 10, right: 8),
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: kPeachLight,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.person_outline_rounded,
                          color: kInk900,
                          size: 18,
                        ),
                      ),
                      prefixIconConstraints:
                          const BoxConstraints(minWidth: 0, minHeight: 0),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Ce nom peut etre modifie plus tard dans les parametres.',
                    style: AppText.bodyS.copyWith(color: kInk500),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _OnboardingHero extends StatelessWidget {
  const _OnboardingHero();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.18,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF161210), Color(0xFF2B1713), kCoral],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 18,
              right: 18,
              child: Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 20,
              child: Container(
                width: 74,
                height: 74,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPeach.withValues(alpha: 0.2),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 142,
                height: 142,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(32),
                  border:
                      Border.all(color: Colors.white.withValues(alpha: 0.08)),
                ),
                child: const Column(
                  children: [
                    Expanded(child: _FlagStripe(color: kFlagBlack)),
                    SizedBox(height: 8),
                    Expanded(child: _FlagStripe(color: kFlagRed)),
                    SizedBox(height: 8),
                    Expanded(child: _FlagStripe(color: kFlagGold)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlagStripe extends StatelessWidget {
  final Color color;

  const _FlagStripe({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }
}

class _SlideData {
  final String title;
  final String subtitle;
  final String kicker;
  final Color accent;

  const _SlideData({
    required this.title,
    required this.subtitle,
    required this.kicker,
    required this.accent,
  });
}
