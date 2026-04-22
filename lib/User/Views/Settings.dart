import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2/core/data/exam_catalog.dart';
import 'package:projet2/core/services/challenge_service.dart';
import 'package:projet2/core/services/progress_service.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';
import 'package:projet2/User/Widget/Drawer.dart';
import 'package:projet2/User/Views/Edit%20Profile.dart';
import 'package:projet2/features/clinical_cases/clinical_cases_page.dart';
import 'package:projet2/features/challenges/weekly_challenges_page.dart';
import 'package:projet2/features/conversation/conversation_drills_page.dart';
import 'package:projet2/features/exams/exam_page.dart';
import 'package:projet2/features/expressions/professional_expressions_page.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _userName = 'Guest';
  String _userInitial = 'G';
  int _streak = 0;
  int _xp = 0;
  int _level = 1;
  int _totalMinutes = 0;
  int _bestQuizScore = 0;
  int _completedQuizzes = 0;
  int _perfectQuizzes = 0;
  int _flashcardsReviewed = 0;
  int _totalSessions = 0;
  double _levelProgress = 0;
  int _xpToNextLevel = 0;
  List<UserBadge> _badges = const [];
  int _weeklyCompleted = 0;
  int _weeklyTotal = 3;
  int _finalExamBestScore = 0;
  List<WeeklyChallenge> _weeklyChallenges = const [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final profile = await ProgressService.getProfileStats();
    final weekly = await ChallengeService.getWeeklySummary();
    final weeklyChallenges = await ChallengeService.getWeeklyChallenges();
    final finalExamBestScore = await ProgressService.getFinalExamBestScore();
    if (!mounted) return;
    setState(() {
      _userName = prefs.getString('name') ?? 'Guest';
      _userInitial = _userName.isNotEmpty ? _userName[0].toUpperCase() : 'G';
      _xp = profile.xp;
      _streak = profile.streak;
      _level = profile.levelInfo.level;
      _totalMinutes = profile.totalMinutes;
      _bestQuizScore = profile.bestQuizScore;
      _completedQuizzes = profile.completedQuizzes;
      _perfectQuizzes = profile.perfectQuizzes;
      _flashcardsReviewed = profile.flashcardsReviewed;
      _totalSessions = profile.totalSessions;
      _levelProgress = profile.levelInfo.progress;
      _xpToNextLevel = profile.levelInfo.xpToNextLevel;
      _badges = profile.badges;
      _weeklyCompleted = weekly['completed'] as int? ?? 0;
      _weeklyTotal = weekly['total'] as int? ?? 3;
      _finalExamBestScore = finalExamBestScore;
      _weeklyChallenges = weeklyChallenges;
    });
  }

  // ── Modals ────────────────────────────────────────────────────────────────

  void _showProgressModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _ProgressModal(),
    );
  }

  void _showBadgesModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _BadgesModal(badges: _badges),
    );
  }

  void _showWeeklyChallengesModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _WeeklyChallengesModal(challenges: _weeklyChallenges),
    );
  }

  void _showFinalExamModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _FinalExamModal(
        bestScore: _finalExamBestScore,
        onLaunch: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ExamPage.finalExam(
                title: 'Examen final',
                subtitle: 'Révision globale des chapitres 1 à 11',
                accentColor: kPurple,
                accentLight: kPurpleLight,
                phrases: buildFinalExamPool(),
              ),
            ),
          ).then((_) => _loadData());
        },
      ),
    );
  }

  void _showResetModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _ResetModal(
        onConfirm: () async {
          Navigator.pop(context);
          await ProgressService.resetAll();
          if (mounted) {
            _loadData();
            _showSnack('Progression réinitialisée.');
          }
        },
      ),
    );
  }

  void _showGuideModal(String title, Widget page) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _NavigationModal(
        title: title,
        onGo: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
      ),
    );
  }

  void _confirmReset() => _showResetModal();

  void _inviteFriend() {
    final box = context.findRenderObject() as RenderBox?;
    Share.share(
      '🇩🇪 Apprends l\'allemand médical avec German Language ! L\'app idéale pour les soignants. #GermanLanguage',
      sharePositionOrigin:
      box == null ? null : box.localToGlobal(Offset.zero) & box.size,
    );
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kScaffold,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _buildTopBar()),
            SliverToBoxAdapter(child: _buildProfileCard()),
            SliverToBoxAdapter(child: _buildWeeklyCard()),
            SliverToBoxAdapter(child: _buildSectionLabel('Compte')),
            SliverToBoxAdapter(child: _buildAccountSection()),
            SliverToBoxAdapter(child: _buildSectionLabel('Apprentissage')),
            SliverToBoxAdapter(child: _buildLearningSection()),
            SliverToBoxAdapter(child: _buildSectionLabel('Révision guidée')),
            SliverToBoxAdapter(child: _buildGuideSection()),
            SliverToBoxAdapter(child: _buildSectionLabel('Application')),
            SliverToBoxAdapter(child: _buildAppSection()),
            SliverToBoxAdapter(child: _buildFooter()),
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }

  // ── Top bar ───────────────────────────────────────────────────────────────

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          _IconButton(
            icon: Icons.grid_view_rounded,
            onTap: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          const SizedBox(width: 12),
          Text('Profil', style: AppText.h2.copyWith(fontSize: 18)),
        ],
      ),
    );
  }

  // ── Profile card ──────────────────────────────────────────────────────────

  Widget _buildProfileCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          color: kFlagBlack,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Avatar + name
                  Row(
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        decoration: const BoxDecoration(
                          color: kFlagGold,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _userInitial,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: kFlagBlack,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _userName,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 9, vertical: 3),
                              decoration: BoxDecoration(
                                color: kFlagGold.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: kFlagGold.withValues(alpha: 0.3)),
                              ),
                              child: Text(
                                'Niveau $_level',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: kFlagGold,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const EditProfilePage()),
                        ).then((_) => _loadData()),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.white.withValues(alpha: 0.12)),
                          ),
                          child: const Icon(Icons.edit_outlined,
                              color: Colors.white, size: 16),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Stats row
                  Row(
                    children: [
                      _DarkStat(
                        icon: Icons.local_fire_department_rounded,
                        iconColor: const Color(0xFFFF6B35),
                        value: '$_streak j',
                        label: 'Série',
                      ),
                      _DarkStat(
                        icon: Icons.bolt_rounded,
                        iconColor: kFlagGold,
                        value: '$_xp XP',
                        label: 'Points',
                      ),
                      _DarkStat(
                        icon: Icons.schedule_rounded,
                        iconColor: const Color(0xFF7DD3C0),
                        value: '$_totalMinutes min',
                        label: 'Temps',
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // XP bar
                  Row(
                    children: [
                      Text(
                        '$_xp XP',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          color: Colors.white.withValues(alpha: 0.45),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Niv. ${_level + 1} — encore $_xpToNextLevel XP',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          color: Colors.white.withValues(alpha: 0.45),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: _levelProgress,
                      minHeight: 7,
                      backgroundColor: Colors.white.withValues(alpha: 0.10),
                      valueColor:
                      const AlwaysStoppedAnimation<Color>(kFlagGold),
                    ),
                  ),
                ],
              ),
            ),

            // Metrics row
            Container(
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.white.withValues(alpha: 0.08))),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Row(
                children: [
                  _DarkMetric(value: '$_completedQuizzes', label: 'Quiz'),
                  _divider(),
                  _DarkMetric(value: '$_bestQuizScore%', label: 'Meilleur'),
                  _divider(),
                  _DarkMetric(
                      value: '$_flashcardsReviewed', label: 'Flashcards'),
                  _divider(),
                  _DarkMetric(value: '$_perfectQuizzes', label: 'Parfaits'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() => Container(
    width: 0.5,
    height: 28,
    color: Colors.white.withValues(alpha: 0.10),
  );

  // ── Weekly card ───────────────────────────────────────────────────────────

  Widget _buildWeeklyCard() {
    final progress =
    _weeklyTotal == 0 ? 0.0 : _weeklyCompleted / _weeklyTotal;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: GestureDetector(
        onTap: _showWeeklyChallengesModal,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: kSurface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: kBorder),
            boxShadow: const [
              BoxShadow(color: kShadow, blurRadius: 12, offset: Offset(0, 4)),
            ],
          ),
          child: Row(
            children: [
              // Ring
              SizedBox(
                width: 52,
                height: 52,
                child: CustomPaint(
                  painter: _RingPainter(
                    progress: progress,
                    ringColor: kFlagGold,
                    trackColor: kInk100,
                    strokeWidth: 5,
                  ),
                  child: Center(
                    child: Text(
                      '$_weeklyCompleted',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: kInk900,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Défis hebdomadaires', style: AppText.labelL),
                    const SizedBox(height: 3),
                    Text(
                      '$_weeklyCompleted / $_weeklyTotal complétés cette semaine',
                      style: AppText.bodyS.copyWith(color: kInk500),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.north_east_rounded,
                  color: kFlagGold, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  // ── Section label ─────────────────────────────────────────────────────────

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: kInk500,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  // ── Sections ──────────────────────────────────────────────────────────────

  Widget _buildAccountSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: _SettingsGroup(items: [
        _SettingsRow(
          icon: Icons.person_outline_rounded,
          iconColor: kFlagBlack,
          iconBg: kInk100,
          label: 'Modifier le profil',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const EditProfilePage()),
          ).then((_) => _loadData()),
        ),
      ]),
    );
  }

  Widget _buildLearningSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: _SettingsGroup(items: [
        _SettingsRow(
          icon: Icons.bar_chart_rounded,
          iconColor: const Color(0xFF3B6D11),
          iconBg: const Color(0xFFEAF3DE),
          label: 'Ma progression',
          trailing: _buildBadgePill('$_completedQuizzes quiz', const Color(0xFF3B6D11), const Color(0xFFEAF3DE)),
          onTap: _showProgressModal,
        ),
        _SettingsRow(
          icon: Icons.workspace_premium_rounded,
          iconColor: const Color(0xFFBA7517),
          iconBg: const Color(0xFFFAEEDA),
          label: 'Mes badges',
          trailing: _buildBadgePill(
            '${_badges.where((b) => b.unlocked).length}/${_badges.length}',
            const Color(0xFFBA7517),
            const Color(0xFFFAEEDA),
          ),
          onTap: _showBadgesModal,
        ),
        _SettingsRow(
          icon: Icons.flag_rounded,
          iconColor: kFlagBlack,
          iconBg: kInk100,
          label: 'Défis hebdomadaires',
          trailing: _buildBadgePill('$_weeklyCompleted/$_weeklyTotal', kFlagBlack, kInk100),
          onTap: _showWeeklyChallengesModal,
        ),
        _SettingsRow(
          icon: Icons.description_outlined,
          iconColor: const Color(0xFF534AB7),
          iconBg: const Color(0xFFEEEDFE),
          label: 'Examen final',
          trailing: _buildBadgePill(
            _finalExamBestScore > 0 ? '$_finalExamBestScore%' : 'À faire',
            const Color(0xFF534AB7),
            const Color(0xFFEEEDFE),
          ),
          onTap: _showFinalExamModal,
        ),
        _SettingsRow(
          icon: Icons.restart_alt_rounded,
          iconColor: const Color(0xFF993C1D),
          iconBg: const Color(0xFFFAECE7),
          label: 'Réinitialiser la progression',
          isDestructive: true,
          onTap: _confirmReset,
        ),
      ]),
    );
  }

  Widget _buildGuideSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: _SettingsGroup(items: [
        _SettingsRow(
          icon: Icons.chat_bubble_outline_rounded,
          iconColor: const Color(0xFF185FA5),
          iconBg: const Color(0xFFE6F1FB),
          label: 'Fiches de conversation',
          onTap: () => _showGuideModal(
              'Fiches de conversation', const ConversationDrillsPage()),
        ),
        _SettingsRow(
          icon: Icons.medical_information_outlined,
          iconColor: const Color(0xFF534AB7),
          iconBg: const Color(0xFFEEEDFE),
          label: 'Expressions professionnelles',
          onTap: () => _showGuideModal(
              'Expressions professionnelles', const ProfessionalExpressionsPage()),
        ),
        _SettingsRow(
          icon: Icons.favorite_border_rounded,
          iconColor: const Color(0xFF993C1D),
          iconBg: const Color(0xFFFAECE7),
          label: 'Cas cliniques',
          onTap: () =>
              _showGuideModal('Cas cliniques', const ClinicalCasesPage()),
        ),
      ]),
    );
  }

  Widget _buildAppSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: _SettingsGroup(items: [
        _SettingsRow(
          icon: Icons.group_outlined,
          iconColor: const Color(0xFF534AB7),
          iconBg: const Color(0xFFEEEDFE),
          label: 'Inviter un ami',
          onTap: _inviteFriend,
        ),
        _SettingsRow(
          icon: Icons.help_outline_rounded,
          iconColor: const Color(0xFFBA7517),
          iconBg: const Color(0xFFFAEEDA),
          label: 'Aide',
          onTap: () => _showSnack('Page d\'aide à venir !'),
        ),
      ]),
    );
  }

  Widget _buildBadgePill(String text, Color fg, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Center(
        child: Column(
          children: [
            const Icon(CupertinoIcons.book_fill, size: 18, color: kInk500),
            const SizedBox(height: 6),
            Text('German Language v2.0',
                style: AppText.bodyS.copyWith(color: kInk500)),
            Text('Conçu pour les soignants',
                style: AppText.caption.copyWith(color: kInk500)),
          ],
        ),
      ),
    );
  }
}

// ── Shared sub-widgets ────────────────────────────────────────────────────────

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: kSurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kBorder),
        ),
        child: Icon(icon, size: 20, color: kInk900),
      ),
    );
  }
}

class _DarkStat extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _DarkStat({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 16),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                color: Colors.white.withValues(alpha: 0.45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DarkMetric extends StatelessWidget {
  final String value;
  final String label;

  const _DarkMetric({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10,
              color: Colors.white.withValues(alpha: 0.40),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final List<_SettingsRow> items;
  const _SettingsGroup({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kSurface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        children: List.generate(items.length, (i) {
          return Column(
            children: [
              items[i],
              if (i < items.length - 1)
                Divider(height: 1, color: kBorder, indent: 62),
            ],
          );
        }),
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String label;
  final Widget? trailing;
  final VoidCallback onTap;
  final bool isDestructive;

  const _SettingsRow({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.onTap,
    this.trailing,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: iconBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 17, color: iconColor),
      ),
      title: Text(
        label,
        style: AppText.labelM.copyWith(
          color: isDestructive ? const Color(0xFF993C1D) : kInk800,
        ),
      ),
      trailing: trailing ??
          const Icon(Icons.chevron_right_rounded, size: 18, color: kInk500),
      onTap: onTap,
    );
  }
}

// ── Modals ────────────────────────────────────────────────────────────────────

class _ModalShell extends StatelessWidget {
  final String title;
  final Widget child;
  final bool scrollable;

  const _ModalShell({
    required this.title,
    required this.child,
    this.scrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: kBorder,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(title, style: AppText.h2.copyWith(fontSize: 18)),
        const SizedBox(height: 20),
        child,
        const SizedBox(height: 24),
      ],
    );

    return Container(
      decoration: const BoxDecoration(
        color: kSurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: scrollable
          ? SingleChildScrollView(child: content)
          : content,
    );
  }
}

// Progress modal
class _ProgressModal extends StatelessWidget {
  static const _chapterNames = {
    1: 'Admission', 2: 'Paramètres', 3: 'Alimentation',
    4: 'Hygiène', 5: 'Physiopathologie', 6: 'Examens',
    7: 'Labo', 8: 'Anesthésie', 9: 'Soins',
    10: 'Urgence', 11: 'Sortie',
  };

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.92,
      minChildSize: 0.4,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: kSurface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36, height: 4,
                decoration: BoxDecoration(color: kBorder, borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 20),
            Text('Progression par chapitre', style: AppText.h2.copyWith(fontSize: 18)),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<Map<int, double>>(
                future: ProgressService.getAllChapterProgresses(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final progresses = snapshot.data!;
                  return ListView(
                    controller: controller,
                    children: progresses.entries.map((e) {
                      final name = _chapterNames[e.key] ?? 'Ch.${e.key}';
                      final pct = (e.value * 100).round();
                      final isDone = e.value >= 1.0;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Ch.${e.key} · $name',
                                  style: AppText.labelM.copyWith(fontSize: 13),
                                ),
                                const Spacer(),
                                Text(
                                  '$pct%',
                                  style: AppText.labelM.copyWith(
                                    fontSize: 13,
                                    color: isDone ? kGreenSuccess : kFlagBlack,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(99),
                              child: LinearProgressIndicator(
                                value: e.value,
                                minHeight: 7,
                                backgroundColor: kInk100,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  isDone ? kGreenSuccess : kFlagGold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Badges modal
class _BadgesModal extends StatelessWidget {
  final List<UserBadge> badges;
  const _BadgesModal({required this.badges});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.92,
      minChildSize: 0.4,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: kSurface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36, height: 4,
                decoration: BoxDecoration(color: kBorder, borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 20),
            Text('Mes badges', style: AppText.h2.copyWith(fontSize: 18)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                controller: controller,
                itemCount: badges.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final badge = badges[index];
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: badge.unlocked ? kSurface : kInk100,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: badge.unlocked
                            ? kGreenSuccess.withValues(alpha: 0.3)
                            : kBorder,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: badge.unlocked ? kGreenSuccessLight : kInk100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            _badgeIcon(badge.id),
                            size: 18,
                            color: badge.unlocked ? kGreenSuccess : kInk500,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(badge.title,
                                  style: AppText.labelM.copyWith(
                                      color: badge.unlocked ? kInk900 : kInk500)),
                              const SizedBox(height: 2),
                              Text(badge.description, style: AppText.bodyS),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: badge.unlocked
                                ? kGreenSuccessLight
                                : kInk100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            badge.unlocked ? 'Débloqué' : 'Verrouillé',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: badge.unlocked ? kGreenSuccess : kInk500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// Weekly challenges modal
class _WeeklyChallengesModal extends StatelessWidget {
  final List<WeeklyChallenge> challenges;
  const _WeeklyChallengesModal({required this.challenges});

  @override
  Widget build(BuildContext context) {
    return _ModalShell(
      title: 'Défis hebdomadaires',
      scrollable: true,
      child: Column(
        children: challenges.map((c) {
          final isDone = c.isCompleted;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: kSurface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isDone
                      ? kGreenSuccess.withValues(alpha: 0.3)
                      : kBorder,
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: CustomPaint(
                      painter: _RingPainter(
                        progress: c.ratio,
                        ringColor: isDone ? kGreenSuccess : kFlagGold,
                        trackColor: kInk100,
                        strokeWidth: 5,
                      ),
                      child: Center(
                        child: Text(
                          '${(c.ratio * 100).round()}%',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: isDone ? kGreenSuccess : kInk900,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.title, style: AppText.labelL),
                        const SizedBox(height: 2),
                        Text(c.description,
                            style: AppText.bodyS.copyWith(color: kInk500)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${c.progress}/${c.target}',
                        style: AppText.labelM.copyWith(
                          color: isDone ? kGreenSuccess : kFlagGold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: isDone ? kGreenSuccessLight : kPeachLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          isDone ? 'Terminé' : 'En cours',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: isDone
                                ? kGreenSuccess
                                : const Color(0xFF7A4A00),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// Final exam modal
class _FinalExamModal extends StatelessWidget {
  final int bestScore;
  final VoidCallback onLaunch;

  const _FinalExamModal({required this.bestScore, required this.onLaunch});

  @override
  Widget build(BuildContext context) {
    return _ModalShell(
      title: 'Examen final',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFEEEDFE),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.description_outlined,
                    color: Color(0xFF534AB7), size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Révision globale',
                          style: AppText.labelL
                              .copyWith(color: const Color(0xFF534AB7))),
                      Text('Chapitres 1 à 11',
                          style: AppText.bodyS.copyWith(color: kInk500)),
                    ],
                  ),
                ),
                if (bestScore > 0)
                  Text(
                    '$bestScore%',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF534AB7),
                    ),
                  ),
              ],
            ),
          ),
          if (bestScore > 0) ...[
            const SizedBox(height: 10),
            Text('Meilleur score : $bestScore%',
                style: AppText.bodyS.copyWith(color: kInk500)),
          ],
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onLaunch,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: kFlagBlack,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_arrow_rounded,
                      color: kFlagGold, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Lancer l\'examen',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Reset modal
class _ResetModal extends StatelessWidget {
  final VoidCallback onConfirm;
  const _ResetModal({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return _ModalShell(
      title: 'Réinitialiser ?',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFAECE7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded,
                    color: Color(0xFF993C1D), size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Toute votre progression, XP et streak seront effacés. Cette action est irréversible.',
                    style: AppText.bodyS.copyWith(color: kInk700),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: kInk100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Annuler',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: kInk700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: onConfirm,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF993C1D),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Réinitialiser',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Navigation modal (for guide section)
class _NavigationModal extends StatelessWidget {
  final String title;
  final VoidCallback onGo;
  const _NavigationModal({required this.title, required this.onGo});

  @override
  Widget build(BuildContext context) {
    return _ModalShell(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Accédez à votre section de révision.',
            style: AppText.bodyM.copyWith(color: kInk500),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onGo,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: kFlagBlack,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ouvrir',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_rounded,
                      color: kFlagGold, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Ring painter ──────────────────────────────────────────────────────────────

class _RingPainter extends CustomPainter {
  const _RingPainter({
    required this.progress,
    required this.ringColor,
    required this.trackColor,
    required this.strokeWidth,
  });

  final double progress;
  final Color ringColor;
  final Color trackColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    const startAngle = -1.5708;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0, 6.2832, false,
      Paint()
        ..color = trackColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );

    if (progress > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle, 6.2832 * progress, false,
        Paint()
          ..color = ringColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress || old.ringColor != ringColor;
}

// ── Badge icon helper ─────────────────────────────────────────────────────────

IconData _badgeIcon(String id) {
  switch (id) {
    case 'first_lesson':
      return Icons.menu_book_rounded;
    case 'first_quiz':
      return Icons.check_circle_outline_rounded;
    case 'perfect_score':
      return Icons.gps_fixed_rounded;
    case 'chapter_master':
      return Icons.flag_rounded;
    case 'streak_7':
      return Icons.local_fire_department_rounded;
    case 'focused_reviewer':
      return Icons.layers_rounded;
    case 'xp_500':
      return Icons.bolt_rounded;
    case 'time_60':
      return Icons.schedule_rounded;
    default:
      return Icons.workspace_premium_rounded;
  }
}