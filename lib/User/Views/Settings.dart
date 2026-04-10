import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  String _userEmail = '';
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

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final profile = await ProgressService.getProfileStats();
    final weekly = await ChallengeService.getWeeklySummary();
    final finalExamBestScore = await ProgressService.getFinalExamBestScore();
    if (!mounted) return;
    setState(() {
      _userName = prefs.getString('name') ?? 'Guest';
      _userEmail = prefs.getString('email') ?? '';
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
    });
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
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildSections()),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  // ── Header utilisateur ────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kBlue, kPurple],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Barre top : menu + titre
          Row(
            children: [
              Builder(
                builder: (ctx) => GestureDetector(
                  onTap: () => _scaffoldKey.currentState?.openDrawer(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.menu_rounded,
                        color: Colors.white, size: 22),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Paramètres',
                style: AppText.h3.copyWith(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Avatar + infos
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.white.withOpacity(0.5), width: 2),
                ),
                alignment: Alignment.center,
                child: Text(
                  _userInitial,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _userName,
                      style: AppText.h3
                          .copyWith(color: Colors.white, fontSize: 18),
                    ),
                    if (_userEmail.isNotEmpty)
                      Text(
                        _userEmail,
                        style: AppText.bodyS.copyWith(
                          color: Colors.white.withOpacity(0.75),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Stats strip
          Row(
            children: [
              _StatChip(
                icon: CupertinoIcons.flame_fill,
                value: '$_streak j',
                label: 'Streak',
              ),
              const SizedBox(width: 10),
              _StatChip(
                icon: CupertinoIcons.bolt_fill,
                value: '$_xp XP',
                label: 'Points',
              ),
              const SizedBox(width: 10),
              _StatChip(
                icon: CupertinoIcons.star_fill,
                value: 'Niv. $_level',
                label: 'Niveau',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Sections ──────────────────────────────────────────────────────────────
  Widget _buildSections() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAdvancedProfileCard(),
          const SizedBox(height: 24),

          // Compte
          _SectionTitle(label: 'Compte'),
          const SizedBox(height: 8),
          _SettingsCard(
            items: [
              _SettingsItem(
                icon: CupertinoIcons.person_fill,
                label: 'Modifier le profil',
                iconColor: kBlue,
                iconBg: kBlueLight,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditProfilePage()),
                ).then((_) => _loadData()),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Apprentissage
          _SectionTitle(label: 'Apprentissage'),
          const SizedBox(height: 8),
          _SettingsCard(
            items: [
              _SettingsItem(
                icon: CupertinoIcons.chart_bar_fill,
                label: 'Ma progression',
                iconColor: kGreen,
                iconBg: kGreenLight,
                trailing: _buildProgressBadge(),
                onTap: _showProgressDetail,
              ),
              _SettingsItem(
                icon: CupertinoIcons.rosette,
                label: 'Mes badges',
                iconColor: kYellow,
                iconBg: kYellowLight,
                trailing: _buildBadgeCount(),
                onTap: _showBadgesDetail,
              ),
              _SettingsItem(
                icon: CupertinoIcons.flag_fill,
                label: 'Défis hebdomadaires',
                iconColor: kBlue,
                iconBg: kBlueLight,
                trailing: Text(
                  '$_weeklyCompleted/$_weeklyTotal',
                  style: AppText.labelS.copyWith(color: kBlue),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const WeeklyChallengesPage()),
                ).then((_) => _loadData()),
              ),
              _SettingsItem(
                icon: CupertinoIcons.doc_text_search,
                label: 'Examen final',
                iconColor: kPurple,
                iconBg: kPurpleLight,
                trailing: Text(
                  _finalExamBestScore > 0 ? '$_finalExamBestScore%' : 'Lancer',
                  style: AppText.labelS.copyWith(color: kPurple),
                ),
                onTap: () => Navigator.push(
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
                ).then((_) => _loadData()),
              ),
              _SettingsItem(
                icon: CupertinoIcons.arrow_counterclockwise,
                label: 'Réinitialiser la progression',
                iconColor: kCoral,
                iconBg: kCoralLight,
                onTap: _confirmReset,
              ),
            ],
          ),

          const SizedBox(height: 24),

          _SectionTitle(label: 'Révision guidée'),
          const SizedBox(height: 8),
          _SettingsCard(
            items: [
              _SettingsItem(
                icon: CupertinoIcons.chat_bubble_2_fill,
                label: 'Fiches de conversation',
                iconColor: kBlue,
                iconBg: kBlueLight,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ConversationDrillsPage(),
                  ),
                ),
              ),
              _SettingsItem(
                icon: CupertinoIcons.person_2_square_stack_fill,
                label: 'Expressions professionnelles',
                iconColor: kPurple,
                iconBg: kPurpleLight,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfessionalExpressionsPage(),
                  ),
                ),
              ),
              _SettingsItem(
                icon: CupertinoIcons.heart_circle_fill,
                label: 'Cas cliniques',
                iconColor: kCoral,
                iconBg: kCoralLight,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ClinicalCasesPage(),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Application
          _SectionTitle(label: 'Application'),
          const SizedBox(height: 8),
          _SettingsCard(
            items: [
              _SettingsItem(
                icon: CupertinoIcons.person_2_fill,
                label: 'Inviter un ami',
                iconColor: kPurple,
                iconBg: kPurpleLight,
                onTap: _inviteFriend,
              ),
              _SettingsItem(
                icon: CupertinoIcons.question_circle_fill,
                label: 'Aide',
                iconColor: kYellow,
                iconBg: kYellowLight,
                onTap: () => _showSnack('Page d\'aide à venir !'),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Footer version
          Center(
            child: Column(
              children: [
                const Icon(
                  CupertinoIcons.book_fill,
                  size: 20,
                  color: kInk500,
                ),
                const SizedBox(height: 6),
                Text(
                  'German Language v2.0',
                  style: AppText.bodyS.copyWith(color: kInk500),
                ),
                Text(
                  'Conçu pour les soignants',
                  style: AppText.caption.copyWith(color: kInk500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Profil avancé', style: AppText.h3),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: kBlueLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Niveau $_level',
                  style: AppText.labelS.copyWith(
                    color: kBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Plus que $_xpToNextLevel XP avant le prochain niveau.',
            style: AppText.bodyS,
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: _levelProgress,
              backgroundColor: kInk100,
              valueColor: const AlwaysStoppedAnimation<Color>(kBlue),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _ProfileMetric(
                icon: CupertinoIcons.time,
                label: 'Temps total',
                value: '$_totalMinutes min',
              ),
              _ProfileMetric(
                icon: CupertinoIcons.check_mark_circled_solid,
                label: 'Quiz validés',
                value: '$_completedQuizzes',
              ),
              _ProfileMetric(
                icon: CupertinoIcons.scope,
                label: 'Meilleur score',
                value: '$_bestQuizScore%',
              ),
              _ProfileMetric(
                icon: CupertinoIcons.rectangle_stack_fill,
                label: 'Flashcards',
                value: '$_flashcardsReviewed',
              ),
              _ProfileMetric(
                icon: CupertinoIcons.chart_bar_alt_fill,
                label: 'Sessions',
                value: '$_totalSessions',
              ),
              _ProfileMetric(
                icon: CupertinoIcons.rosette,
                label: 'Scores parfaits',
                value: '$_perfectQuizzes',
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Badges récents', style: AppText.labelM),
          const SizedBox(height: 10),
          SizedBox(
            height: 58,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _badges.take(6).length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final badge = _badges.take(6).toList()[index];
                return _BadgePill(badge: badge);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBadge() {
    return FutureBuilder<Map<int, double>>(
      future: ProgressService.getAllChapterProgresses(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();
        final progresses = snapshot.data!;
        final completed = progresses.values.where((p) => p >= 1.0).length;
        final total = progresses.length;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: kGreenLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '$completed/$total',
            style: AppText.caption.copyWith(
              color: kGreen,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      },
    );
  }

  Widget _buildBadgeCount() {
    final unlocked = _badges.where((badge) => badge.unlocked).length;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: kYellowLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$unlocked/${_badges.length}',
        style: AppText.caption.copyWith(
          color: kYellow,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  void _showProgressDetail() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => _ProgressSheet(),
    );
  }

  void _showBadgesDetail() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => _BadgesSheet(badges: _badges),
    );
  }

  void _confirmReset() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Réinitialiser ?', style: AppText.h3),
        content: Text(
          'Toute votre progression, XP et streak seront effacés. Cette action est irréversible.',
          style: AppText.bodyM,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child:
                Text('Annuler', style: AppText.labelM.copyWith(color: kInk500)),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await ProgressService.resetAll();
              if (mounted) {
                _loadData();
                _showSnack('Progression réinitialisée.');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kCoral,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Réinitialiser'),
          ),
        ],
      ),
    );
  }

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
}

// ── Progress Bottom Sheet ──────────────────────────────────────────────────────
class _ProgressSheet extends StatelessWidget {
  static const _chapterNames = {
    1: 'Admission',
    2: 'Paramètres',
    3: 'Alimentation',
    4: 'Hygiène',
    5: 'Physiopathologie',
    6: 'Examens',
    7: 'Labo',
    8: 'Anesthésie',
    9: 'Soins',
    10: 'Urgence',
    11: 'Sortie',
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    color: kBorder, borderRadius: BorderRadius.circular(2))),
          ),
          const SizedBox(height: 20),
          Text('Progression par chapitre', style: AppText.h3),
          const SizedBox(height: 16),
          FutureBuilder<Map<int, double>>(
            future: ProgressService.getAllChapterProgresses(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final progresses = snapshot.data!;
              return Column(
                children: progresses.entries.map((e) {
                  final name = _chapterNames[e.key] ?? 'Ch.${e.key}';
                  final pct = (e.value * 100).round();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 90,
                          child: Text(
                            'Ch.${e.key} $name',
                            style: AppText.bodyS,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: e.value,
                              backgroundColor: kInk100,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                e.value >= 1.0 ? kGreen : kBlue,
                              ),
                              minHeight: 7,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 36,
                          child: Text(
                            '$pct%',
                            style: AppText.labelS.copyWith(
                              color: e.value >= 1.0 ? kGreen : kBlue,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BadgesSheet extends StatelessWidget {
  final List<UserBadge> badges;

  const _BadgesSheet({required this.badges});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: kBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Mes badges', style: AppText.h3),
          const SizedBox(height: 16),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: badges.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final badge = badges[index];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: badge.unlocked ? Colors.white : kInk100,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: kBorder),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _badgeIcon(badge.id),
                        size: 20,
                        color: badge.unlocked ? kInk800 : kInk500,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              badge.title,
                              style: AppText.labelM.copyWith(
                                color: badge.unlocked ? kInk900 : kInk500,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              badge.description,
                              style: AppText.bodyS,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        badge.unlocked ? 'Débloqué' : 'Verrouillé',
                        style: AppText.caption.copyWith(
                          color: badge.unlocked ? kGreen : kInk500,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── UI Components ─────────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String label;
  const _SectionTitle({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: AppText.caption.copyWith(
        color: kInk500,
        letterSpacing: 0.8,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<_SettingsItem> items;
  const _SettingsCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color iconBg;
  final Widget? trailing;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.iconBg,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: iconBg,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Icon(icon, size: 18, color: iconColor),
      ),
      title: Text(label, style: AppText.labelM.copyWith(color: kInk800)),
      trailing: trailing ??
          Icon(
            CupertinoIcons.chevron_forward,
            size: 15,
            color: kInk500,
          ),
      onTap: onTap,
    );
  }
}

class _ProfileMetric extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProfileMetric({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 146,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kScaffold,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: kInk700),
          const SizedBox(height: 8),
          Text(value, style: AppText.h3.copyWith(fontSize: 16)),
          const SizedBox(height: 2),
          Text(label, style: AppText.bodyS),
        ],
      ),
    );
  }
}

class _BadgePill extends StatelessWidget {
  final UserBadge badge;

  const _BadgePill({required this.badge});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: badge.unlocked ? Colors.white : kInk100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _badgeIcon(badge.id),
            size: 15,
            color: badge.unlocked ? kInk800 : kInk500,
          ),
          Text(
            badge.title,
            style: AppText.caption.copyWith(
              color: badge.unlocked ? kInk800 : kInk500,
              fontSize: 7.5,
              height: 1.0,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatChip({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

IconData _badgeIcon(String id) {
  switch (id) {
    case 'first_lesson':
      return CupertinoIcons.book;
    case 'first_quiz':
      return CupertinoIcons.check_mark_circled;
    case 'perfect_score':
      return CupertinoIcons.scope;
    case 'chapter_master':
      return CupertinoIcons.flag_fill;
    case 'streak_7':
      return CupertinoIcons.flame_fill;
    case 'focused_reviewer':
      return CupertinoIcons.rectangle_stack_fill;
    case 'xp_500':
      return CupertinoIcons.bolt_fill;
    case 'time_60':
      return CupertinoIcons.time;
    default:
      return CupertinoIcons.rosette;
  }
}
