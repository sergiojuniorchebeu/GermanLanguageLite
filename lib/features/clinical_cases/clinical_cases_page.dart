import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projet2/core/data/practice_catalog.dart';
import 'package:projet2/core/services/progress_service.dart';
import 'package:projet2/core/services/sfx_service.dart';
import 'package:projet2/core/theme/colors.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ASSETS ATTENDUS dans assets/img/
//
//   character_patient_man.png     → illustration corps entier, fond transparent
//   character_patient_woman.png
//   character_patient_child.png
//   character_patient_elder.png
//   character_nurse.png           → infirmier(e) corps entier, fond transparent
//
// Style recommandé : illustrations vectorielles style Duolingo/cartoon,
// personnage debout, PNG fond transparent, ~400px de haut.
// Fallback automatique sur icône colorée si l'asset est absent.
// ─────────────────────────────────────────────────────────────────────────────

String _patientCharacter(ClinicalCase c) {
  if (c.id.contains('child') || c.id.contains('pediatr')) {
    return 'assets/img/enfant.png';
  }
  if (c.id.contains('elder') || c.id.contains('geriatr')) {
    return 'assets/img/people.png';
  }
  if (c.id.contains('woman') || c.id.contains('femme')) {
    return 'assets/img/fille.png';
  }
  return 'assets/img/people.png';
}

const String _nurseCharacter = 'assets/img/nurses.png';

// ─────────────────────────────────────────────────────────────────────────────
// PAGE LISTE
// ─────────────────────────────────────────────────────────────────────────────

class ClinicalCasesPage extends StatefulWidget {
  const ClinicalCasesPage({super.key});

  @override
  State<ClinicalCasesPage> createState() => _ClinicalCasesPageState();
}

class _ClinicalCasesPageState extends State<ClinicalCasesPage> {
  Map<String, int> _bestScores = const {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final scores = await ProgressService.getClinicalCaseBestScores();
    if (!mounted) return;
    setState(() {
      _bestScores = scores;
      _isLoading = false;
    });
  }

  bool _isUnlocked(int index) {
    if (index == 0) return true;
    final previous = clinicalCases[index - 1];
    return (_bestScores[previous.id] ?? 0) >= previous.passingScore;
  }

  int get _validatedCases => clinicalCases
      .where((c) => (_bestScores[c.id] ?? 0) >= c.passingScore)
      .length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffold,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: kFlagGold))
            : CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: _ListHero(
                validatedCases: _validatedCases,
                totalCases: clinicalCases.length,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final item = clinicalCases[index];
                    final unlocked = _isUnlocked(index);
                    final best = _bestScores[item.id] ?? 0;
                    return _CaseCard(
                      clinicalCase: item,
                      isUnlocked: unlocked,
                      bestScore: best,
                      patientCharacter: _patientCharacter(item),
                      onTap: unlocked
                          ? () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => _SessionPage(
                              clinicalCase: item,
                            ),
                          ),
                        );
                        _loadProgress();
                      }
                          : null,
                    );
                  },
                  childCount: clinicalCases.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Hero soft ─────────────────────────────────────────────────────────────────

class _ListHero extends StatelessWidget {
  final int validatedCases;
  final int totalCases;

  const _ListHero({required this.validatedCases, required this.totalCases});

  @override
  Widget build(BuildContext context) {
    final progress = totalCases == 0 ? 0.0 : validatedCases / totalCases;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cas cliniques',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: kInk900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Parcours guidé · $validatedCases / $totalCases validés',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              color: kInk500,
            ),
          ),
          const SizedBox(height: 16),
          // Card progression soft — anneau + texte, pas de fond noir
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: kBorder),
              boxShadow: const [
                BoxShadow(
                    color: kShadow, blurRadius: 10, offset: Offset(0, 3)),
              ],
            ),
            child: Row(
              children: [
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
                        '${(progress * 100).round()}%',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
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
                      const Text(
                        'Progression globale',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: kInk900,
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        'Termine chaque cas pour débloquer le suivant.',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          color: kInk500,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                // Pill validés
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: kInk100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$validatedCases/$totalCases',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: kInk700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Case card ─────────────────────────────────────────────────────────────────

class _CaseCard extends StatelessWidget {
  final ClinicalCase clinicalCase;
  final bool isUnlocked;
  final int bestScore;
  final String patientCharacter;
  final VoidCallback? onTap;

  const _CaseCard({
    required this.clinicalCase,
    required this.isUnlocked,
    required this.bestScore,
    required this.patientCharacter,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final passed = bestScore >= clinicalCase.passingScore;
    final started = bestScore > 0 && !passed;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        opacity: isUnlocked ? 1.0 : 0.52,
        duration: const Duration(milliseconds: 200),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: passed
                  ? clinicalCase.accentColor.withValues(alpha: 0.35)
                  : kBorder,
              width: passed ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: passed
                    ? clinicalCase.accentColor.withValues(alpha: 0.08)
                    : kShadow,
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _ScoreBadge(
                            bestScore: bestScore,
                            passed: passed,
                            started: started,
                            isUnlocked: isUnlocked,
                            accentColor: clinicalCase.accentColor,
                            accentLight: clinicalCase.accentLight,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            clinicalCase.title,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: kInk900,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            isUnlocked
                                ? 'Score min. ${clinicalCase.passingScore}%'
                                : 'Valide le cas précédent d\'abord',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11,
                              color: isUnlocked ? kInk500 : kCoral,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            clinicalCase.situation,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: kInk700,
                              height: 1.55,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 18),
                        ],
                      ),
                    ),
                    // Illustration patient corps entier
                    SizedBox(
                      width: 90,
                      height: 110,
                      child: isUnlocked
                          ? _CharacterImage(
                        asset: patientCharacter,
                        fallbackColor: clinicalCase.accentLight,
                        fallbackIcon: Icons.person_rounded,
                        fallbackIconColor: clinicalCase.accentColor,
                      )
                          : Container(
                        margin: const EdgeInsets.only(right: 18),
                        decoration: BoxDecoration(
                          color: kInk100,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(Icons.lock_rounded,
                            color: kInk500, size: 28),
                      ),
                    ),
                  ],
                ),
              ),
              if (isUnlocked)
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    decoration: BoxDecoration(
                      color: passed ? clinicalCase.accentColor : kFlagBlack,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          passed
                              ? Icons.replay_rounded
                              : Icons.play_arrow_rounded,
                          color: passed ? Colors.white : kFlagGold,
                          size: 18,
                        ),
                        const SizedBox(width: 7),
                        Text(
                          passed
                              ? 'Rejouer'
                              : started
                              ? 'Continuer'
                              : 'Commencer',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
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

class _ScoreBadge extends StatelessWidget {
  final int bestScore;
  final bool passed;
  final bool started;
  final bool isUnlocked;
  final Color accentColor;
  final Color accentLight;

  const _ScoreBadge({
    required this.bestScore,
    required this.passed,
    required this.started,
    required this.isUnlocked,
    required this.accentColor,
    required this.accentLight,
  });

  @override
  Widget build(BuildContext context) {
    if (!isUnlocked) return _pill('Verrouillé', kInk500, kInk100);
    if (passed) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
        decoration: BoxDecoration(
            color: accentLight, borderRadius: BorderRadius.circular(99)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_rounded, color: accentColor, size: 12),
            const SizedBox(width: 4),
            Text('$bestScore%',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: accentColor)),
          ],
        ),
      );
    }
    if (started) {
      return _pill(
          '$bestScore% · Réessayer', const Color(0xFF7A4A00), kPeachLight);
    }
    return _pill('Nouveau', kInk700, kInk100);
  }

  Widget _pill(String label, Color fg, Color bg) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
    decoration:
    BoxDecoration(color: bg, borderRadius: BorderRadius.circular(99)),
    child: Text(label,
        style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: fg)),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// PAGE SESSION — style Duolingo
// ─────────────────────────────────────────────────────────────────────────────

class _SessionPage extends StatefulWidget {
  final ClinicalCase clinicalCase;
  const _SessionPage({required this.clinicalCase});

  @override
  State<_SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<_SessionPage> {
  final ScrollController _scroll = ScrollController();
  final List<_Msg> _history = [];

  int _currentTurnIndex = 0;
  int _correctAnswers = 0;
  int? _selectedIndex;
  bool _showFeedback = false;
  bool _isFinished = false;
  int _xpGained = 0;
  int _bestScore = 0;

  ClinicalCase get _case => widget.clinicalCase;
  ClinicalCaseTurn get _turn => _case.turns[_currentTurnIndex];

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _scrollBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _selectAnswer(int index) async {
    if (_selectedIndex != null) return;
    final isCorrect = index == _turn.correctIndex;
    if (isCorrect) {
      _correctAnswers++;
      unawaited(SfxService.playQuizSuccess());
    } else {
      unawaited(SfxService.playQuizFail());
    }

    setState(() {
      _selectedIndex = index;
      _showFeedback = true;
    });
    _scrollBottom();

    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;

    if (_currentTurnIndex >= _case.turns.length - 1) {
      await _finish();
      return;
    }

    setState(() {
      _history.add(_Msg(
        patientLine: _turn.patientLine,
        selectedReply: _turn.options[index],
        correctionReply:
            isCorrect ? null : _turn.options[_turn.correctIndex],
        isCorrect: isCorrect,
      ));
      _currentTurnIndex++;
      _selectedIndex = null;
      _showFeedback = false;
    });
    _scrollBottom();
  }

  Future<void> _finish() async {
    final score = ((_correctAnswers / _case.turns.length) * 100).round();
    final xp = await ProgressService.completeClinicalCase(
      _case.id, score,
      passingScore: _case.passingScore,
    );
    final best = await ProgressService.getClinicalCaseBestScore(_case.id);
    if (!mounted) return;
    setState(() {
      _xpGained = xp;
      _bestScore = best;
      _isFinished = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffold,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: _isFinished ? _buildResult() : _buildTurn(),
            ),
          ],
        ),
      ),
    );
  }

  // ── Barre du haut — pas de bouton retour ─────────────────────────────────

  Widget _buildTopBar() {
    final progress = _isFinished
        ? 1.0
        : _currentTurnIndex / _case.turns.length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: kInk100,
                valueColor:
                AlwaysStoppedAnimation<Color>(_case.accentColor),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: kFlagGold.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${_currentTurnIndex + (_isFinished ? 1 : 0)} / ${_case.turns.length}',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: kFlagBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Tour courant ─────────────────────────────────────────────────────────

  Widget _buildTurn() {
    final patientAsset = _patientCharacter(_case);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView(
            controller: _scroll,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            physics: const BouncingScrollPhysics(),
            children: [
              ..._history.map(
                (msg) => _ConversationTurn(
                  patientLine: msg.patientLine,
                  selectedReply: msg.selectedReply,
                  correctionReply: msg.correctionReply,
                  isCorrect: msg.isCorrect,
                  patientAsset: patientAsset,
                  patientAccentLight: _case.accentLight,
                  patientAccentColor: _case.accentColor,
                ),
              ),
              _PatientMessage(
                patientLine: _turn.patientLine,
                patientAsset: patientAsset,
                patientAccentLight: _case.accentLight,
                patientAccentColor: _case.accentColor,
              ),
              if (_showFeedback && _selectedIndex != null)
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: _NurseMessage(
                    nurseReply: _turn.options[_selectedIndex!],
                    isCorrect: _turn.correctIndex == _selectedIndex,
                  ),
                ),
            ],
          ),
        ),

        // Options
        _OptionsPanel(
          prompt: _turn.prompt,
          options: _turn.options,
          selectedIndex: _selectedIndex,
          correctIndex: _turn.correctIndex,
          showFeedback: _showFeedback,
          accentColor: _case.accentColor,
          onSelect: _selectAnswer,
        ),
      ],
    );
  }

  // ── Résultat ─────────────────────────────────────────────────────────────

  Widget _buildResult() {
    final score = ((_correctAnswers / _case.turns.length) * 100).round();
    final passed = score >= _case.passingScore;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Deux personnages face à face
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 90,
                height: 120,
                child: _CharacterImage(
                  asset: _nurseCharacter,
                  fallbackColor: const Color(0xFFFAECE7),
                  fallbackIcon: Icons.medical_services_rounded,
                  fallbackIconColor: const Color(0xFFD85A30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: passed ? kGreenSuccessLight : kPeachLight,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: passed
                          ? kGreenSuccess.withValues(alpha: 0.4)
                          : kCoral.withValues(alpha: 0.4),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    passed ? Icons.check_rounded : Icons.close_rounded,
                    color: passed ? kGreenSuccess : kCoral,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(
                width: 90,
                height: 120,
                child: _CharacterImage(
                  asset: _patientCharacter(_case),
                  fallbackColor: _case.accentLight,
                  fallbackIcon: Icons.person_rounded,
                  fallbackIconColor: _case.accentColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: kBorder),
              boxShadow: const [
                BoxShadow(
                    color: kShadow, blurRadius: 16, offset: Offset(0, 6)),
              ],
            ),
            child: Column(
              children: [
                Text(
                  passed ? 'Cas validé !' : 'Cas à refaire',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: passed ? kGreenSuccess : kCoral,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _case.completionMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: kInk600,
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _ResultChip(
                        label: 'Score',
                        value: '$score%',
                        color: passed ? kGreenSuccess : kCoral),
                    const SizedBox(width: 10),
                    _ResultChip(
                        label: 'Meilleur',
                        value: '$_bestScore%',
                        color: kFlagGold),
                    const SizedBox(width: 10),
                    _ResultChip(
                        label: 'XP',
                        value: '+$_xpGained',
                        color: kFlagBlack),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Seuil de validation : ${_case.passingScore}%',
                  style: const TextStyle(
                      fontFamily: 'Poppins', fontSize: 11, color: kInk500),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: kFlagBlack,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'Retour aux cas',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// COMPOSANTS DIALOGUE
// ─────────────────────────────────────────────────────────────────────────────

class _ConversationTurn extends StatelessWidget {
  final String patientLine;
  final String selectedReply;
  final String? correctionReply;
  final bool isCorrect;
  final String patientAsset;
  final Color patientAccentLight;
  final Color patientAccentColor;

  const _ConversationTurn({
    required this.patientLine,
    required this.selectedReply,
    required this.correctionReply,
    required this.isCorrect,
    required this.patientAsset,
    required this.patientAccentLight,
    required this.patientAccentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        children: [
          _PatientMessage(
            patientLine: patientLine,
            patientAsset: patientAsset,
            patientAccentLight: patientAccentLight,
            patientAccentColor: patientAccentColor,
          ),
          const SizedBox(height: 12),
          _NurseMessage(
            nurseReply: selectedReply,
            isCorrect: isCorrect,
          ),
          if (correctionReply != null) ...[
            const SizedBox(height: 10),
            _NurseMessage(
              nurseReply: correctionReply!,
              isCorrect: true,
              badgeText: 'Il fallait dire',
            ),
          ],
        ],
      ),
    );
  }
}

class _PatientMessage extends StatelessWidget {
  final String patientLine;
  final String patientAsset;
  final Color patientAccentLight;
  final Color patientAccentColor;

  const _PatientMessage({
    required this.patientLine,
    required this.patientAsset,
    required this.patientAccentLight,
    required this.patientAccentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: 100,
          height: 140,
          child: _CharacterImage(
            asset: patientAsset,
            fallbackColor: patientAccentLight,
            fallbackIcon: Icons.person_rounded,
            fallbackIconColor: patientAccentColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SpeechBubble(
            text: patientLine,
            direction: _BubbleDirection.left,
            bgColor: Colors.white,
            borderColor: kBorder,
            textColor: kInk900,
          ),
        ),
      ],
    );
  }
}

class _NurseMessage extends StatelessWidget {
  final String nurseReply;
  final bool isCorrect;
  final String? badgeText;

  const _NurseMessage({
    required this.nurseReply,
    required this.isCorrect,
    this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: _SpeechBubble(
            text: nurseReply,
            direction: _BubbleDirection.right,
            bgColor: isCorrect ? kGreenSuccessLight : kCoralLight,
            borderColor: isCorrect
                ? kGreenSuccess.withValues(alpha: 0.5)
                : kCoral.withValues(alpha: 0.5),
            textColor: kInk900,
            badge:
                badgeText ?? (isCorrect ? 'Bonne réponse !' : 'Mauvaise réponse'),
            badgeIsCorrect: isCorrect,
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 84,
          height: 120,
          child: _CharacterImage(
            asset: _nurseCharacter,
            fallbackColor: const Color(0xFFFAECE7),
            fallbackIcon: Icons.medical_services_rounded,
            fallbackIconColor: const Color(0xFFD85A30),
          ),
        ),
      ],
    );
  }
}

enum _BubbleDirection { left, right }

/// Bulle de dialogue style Duolingo avec queue directionnelle
class _SpeechBubble extends StatelessWidget {
  final String text;
  final _BubbleDirection direction;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  final String? badge;
  final bool? badgeIsCorrect;

  const _SpeechBubble({
    required this.text,
    required this.direction,
    required this.bgColor,
    required this.borderColor,
    required this.textColor,
    this.badge,
    this.badgeIsCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: direction == _BubbleDirection.left
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft:
              Radius.circular(direction == _BubbleDirection.left ? 4 : 16),
              bottomRight:
              Radius.circular(direction == _BubbleDirection.right ? 4 : 16),
            ),
            border: Border.all(color: borderColor, width: 1.3),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              color: textColor,
              height: 1.45,
            ),
          ),
        ),
        if (badge != null) ...[
          const SizedBox(height: 5),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                badgeIsCorrect == true
                    ? Icons.check_circle_rounded
                    : Icons.cancel_rounded,
                size: 13,
                color: badgeIsCorrect == true ? kGreenSuccess : kCoral,
              ),
              const SizedBox(width: 4),
              Text(
                badge!,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: badgeIsCorrect == true ? kGreenSuccess : kCoral,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

/// Panel options en bas (bottom sheet blanc)
class _OptionsPanel extends StatelessWidget {
  final String prompt;
  final List<String> options;
  final int? selectedIndex;
  final int correctIndex;
  final bool showFeedback;
  final Color accentColor;
  final void Function(int) onSelect;

  const _OptionsPanel({
    required this.prompt,
    required this.options,
    required this.selectedIndex,
    required this.correctIndex,
    required this.showFeedback,
    required this.accentColor,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x18150F09),
            blurRadius: 20,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                  color: kInk100, borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Choisis ta réponse',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: kInk700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            prompt,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: kInk900,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          ...List.generate(options.length, (i) {
            final isSelected = selectedIndex == i;
            final isCorrect = showFeedback && i == correctIndex;
            final isWrong =
                showFeedback && isSelected && i != correctIndex;

            Color bg = Colors.white;
            Color border = kBorder;

            if (isCorrect) {
              bg = kGreenSuccessLight;
              border = kGreenSuccess;
            } else if (isWrong) {
              bg = kCoralLight;
              border = kCoral;
            } else if (isSelected) {
              bg = kInk100;
              border = kInk500;
            }

            return GestureDetector(
              onTap: selectedIndex != null ? null : () => onSelect(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 9),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 13),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: border, width: 1.3),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        options[i],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: kInk900,
                          height: 1.4,
                        ),
                      ),
                    ),
                    if (isCorrect)
                      const Icon(Icons.check_circle_rounded,
                          color: kGreenSuccess, size: 18)
                    else if (isWrong)
                      const Icon(Icons.cancel_rounded,
                          color: kCoral, size: 18),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// COMPOSANTS PARTAGÉS
// ─────────────────────────────────────────────────────────────────────────────

/// Illustration corps entier avec fallback gracieux
class _CharacterImage extends StatelessWidget {
  final String asset;
  final Color fallbackColor;
  final IconData fallbackIcon;
  final Color? fallbackIconColor;

  const _CharacterImage({
    required this.asset,
    required this.fallbackColor,
    required this.fallbackIcon,
    this.fallbackIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      fit: BoxFit.contain,
      alignment: Alignment.bottomCenter,
      errorBuilder: (_, __, ___) => Container(
        decoration: BoxDecoration(
          color: fallbackColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          fallbackIcon,
          color: fallbackIconColor ?? Colors.white,
          size: 36,
        ),
      ),
    );
  }
}

class _ResultChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _ResultChip(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(value,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: color)),
            const SizedBox(height: 3),
            Text(label,
                style: const TextStyle(
                    fontFamily: 'Poppins', fontSize: 11, color: kInk500)),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DATA MODEL
// ─────────────────────────────────────────────────────────────────────────────

class _Msg {
  final String patientLine;
  final String selectedReply;
  final String? correctionReply;
  final bool isCorrect;

  const _Msg({
    required this.patientLine,
    required this.selectedReply,
    required this.correctionReply,
    required this.isCorrect,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// RING PAINTER
// ─────────────────────────────────────────────────────────────────────────────

class _RingPainter extends CustomPainter {
  final double progress;
  final Color ringColor;
  final Color trackColor;
  final double strokeWidth;

  const _RingPainter({
    required this.progress,
    required this.ringColor,
    required this.trackColor,
    required this.strokeWidth,
  });

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
