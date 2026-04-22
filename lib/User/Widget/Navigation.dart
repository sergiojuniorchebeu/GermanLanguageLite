import 'package:flutter/material.dart';
import 'package:projet2/User/Views/ChaptersPage.dart';
import 'package:projet2/User/Views/HomeUserPage.dart';
import 'package:projet2/User/Views/Settings.dart';
import 'package:projet2/core/data/exam_catalog.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';
import 'package:projet2/features/conversation/conversation_drills_page.dart';
import 'package:projet2/features/exams/exam_page.dart';

class NavigationHomePage extends StatefulWidget {
  const NavigationHomePage({super.key});

  @override
  State<NavigationHomePage> createState() => _NavigationHomePageState();
}

class _NavigationHomePageState extends State<NavigationHomePage> {
  int _currentIndex = 0;

  late final List<Widget> _pages = const [
    HomeUserPage(),
    ChaptersPage(),
    ConversationDrillsPage(),
    SettingsPage(),
  ];

  void _openFinalExam() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ExamPage.finalExam(
          title: 'Examen final',
          subtitle: 'Evaluation generale',
          accentColor: kCoral,
          accentLight: kCoralLight,
          phrases: buildFinalExamPool(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffold,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: IndexedStack(
              index: _currentIndex,
              children: _pages,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _StudentBottomBar(
              currentIndex: _currentIndex,
              onDestinationSelected: (index) {
                setState(() => _currentIndex = index);
              },
              onCenterPressed: _openFinalExam,
            ),
          ),
        ],
      ),
    );
  }
}

class _StudentBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final VoidCallback onCenterPressed;

  const _StudentBottomBar({
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.onCenterPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return SizedBox(
      height: 110 + bottomInset,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            left: 18,
            right: 18,
            bottom: 16 + bottomInset,
            child: Container(
              height: 72,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: kFlagBlack,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.16),
                    blurRadius: 28,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _BottomNavItem(
                      label: 'Home',
                      icon: Icons.home_rounded,
                      isSelected: currentIndex == 0,
                      onTap: () => onDestinationSelected(0),
                    ),
                  ),
                  Expanded(
                    child: _BottomNavItem(
                      label: 'Chapitres',
                      icon: Icons.menu_book_rounded,
                      isSelected: currentIndex == 1,
                      onTap: () => onDestinationSelected(1),
                    ),
                  ),
                  const SizedBox(width: 84),
                  Expanded(
                    child: _BottomNavItem(
                      label: 'Conversation',
                      icon: Icons.forum_rounded,
                      isSelected: currentIndex == 2,
                      onTap: () => onDestinationSelected(2),
                    ),
                  ),
                  Expanded(
                    child: _BottomNavItem(
                      label: 'Profil',
                      icon: Icons.person_rounded,
                      isSelected: currentIndex == 3,
                      onTap: () => onDestinationSelected(3),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30 + bottomInset,
            child: GestureDetector(
              onTap: onCenterPressed,
              child: Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [kFlagGold, kYellow],
                  ),
                  border: Border.all(color: kScaffold, width: 6),
                  boxShadow: [
                    BoxShadow(
                      color: kFlagGold.withValues(alpha: 0.34),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.workspace_premium_rounded,
                      color: kFlagBlack,
                      size: 22,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Examen',
                      style: AppText.caption.copyWith(
                        color: kFlagBlack,
                        fontWeight: FontWeight.w800,
                        fontSize: 9.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? kFlagGold : Colors.white.withValues(alpha: 0.62);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 21),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.caption.copyWith(
                color: color,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 10.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
