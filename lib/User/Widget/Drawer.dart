import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';
import 'package:projet2/core/services/progress_service.dart';
import 'package:projet2/User/Views/Edit%20Profile.dart';
import 'package:projet2/User/Views/HomeUserPage.dart';
import 'package:projet2/User/Views/Settings.dart';
import 'package:projet2/User/Widget/Navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String _userInitial = 'G';
  String _userName = 'Guest';
  String _userEmail = '';
  int _streak = 0;
  int _xp = 0;
  int _level = 1;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final xp = await ProgressService.getXP();
    final streak = await ProgressService.getStreak();
    final levelInfo = ProgressService.getLevelInfoFromXP(xp);
    if (!mounted) return;
    setState(() {
      _userName = prefs.getString('name') ?? 'Guest';
      _userEmail = prefs.getString('email') ?? '';
      _userInitial =
          _userName.isNotEmpty ? _userName[0].toUpperCase() : 'G';
      _streak = streak;
      _xp = xp;
      _level = levelInfo.level;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        children: [
          // ── Header avec gradient ──────────────────────────────────────
          _buildHeader(),

          // ── Menu ─────────────────────────────────────────────────────
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                _DrawerItem(
                  icon: CupertinoIcons.house_fill,
                  title: 'Accueil',
                  color: kBlue,
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const NavigationHomePage()),
                      (route) => false,
                    );
                  },
                ),
                _DrawerItem(
                  icon: CupertinoIcons.person_fill,
                  title: 'Profil',
                  color: kPurple,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EditProfilePage()),
                  ),
                ),
                _DrawerItem(
                  icon: CupertinoIcons.book_fill,
                  title: 'Chapitres',
                  color: kGreen,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeUserPage()),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 8),
                  child: Divider(color: kBorder, thickness: 1, height: 1),
                ),

                _DrawerItem(
                  icon: CupertinoIcons.settings,
                  title: 'Paramètres',
                  color: kInk500,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsPage()),
                  ),
                ),
              ],
            ),
          ),

          // ── Footer ───────────────────────────────────────────────────
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 56, 24, 28),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kBlue, kPurple],
        ),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.6),
                width: 2,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              _userInitial,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            _userName,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          if (_userEmail.isNotEmpty) ...[
            const SizedBox(height: 3),
            Text(
              _userEmail,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: Colors.white.withOpacity(0.75),
              ),
            ),
          ],
          const SizedBox(height: 16),
          // Mini stats
          Row(
            children: [
              _HeaderStat(
                icon: CupertinoIcons.flame_fill,
                value: '$_streak j',
              ),
              const SizedBox(width: 16),
              _HeaderStat(
                icon: CupertinoIcons.bolt_fill,
                value: '$_xp XP',
              ),
              const SizedBox(width: 16),
              _HeaderStat(
                icon: CupertinoIcons.star_fill,
                value: 'Niv. $_level',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Row(
        children: [
          const Icon(CupertinoIcons.book_fill, size: 16, color: kInk500),
          const SizedBox(width: 8),
          Text(
            'German Language v2',
            style: AppText.labelS.copyWith(color: kInk500),
          ),
        ],
      ),
    );
  }
}

// ── Mini stat header ─────────────────────────────────────────────────────────
class _HeaderStat extends StatelessWidget {
  final IconData icon;
  final String value;

  const _HeaderStat({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 13, color: Colors.white),
          const SizedBox(width: 5),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Drawer item ──────────────────────────────────────────────────────────────
class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 20, color: color),
      ),
      title: Text(
        title,
        style: AppText.labelL.copyWith(color: kInk800),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 14,
        color: kInk500,
      ),
      onTap: onTap,
    );
  }
}
