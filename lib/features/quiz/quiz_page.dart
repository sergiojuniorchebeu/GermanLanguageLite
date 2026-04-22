import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:projet2/core/services/progress_service.dart';
import 'package:projet2/core/services/sfx_service.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

// Couleurs sémantiques quiz — indépendantes de la palette drapeau
const _kSuccess = Color(0xFF16A34A);
const _kSuccessLight = Color(0xFFDCFCE7);
const _kError = Color(0xFFDC2626);
const _kErrorLight = Color(0xFFFEE2E2);

// ─────────────────────────────────────────────────────────────────────────────
// QuizPage
// ─────────────────────────────────────────────────────────────────────────────
class QuizPage extends StatefulWidget {
  final int chapterNumber;
  final String lessonTitle;
  final Color accentColor;
  final Color accentLight;
  final List<PhraseEntry> phrases;

  const QuizPage({
    super.key,
    required this.chapterNumber,
    required this.lessonTitle,
    required this.accentColor,
    required this.accentLight,
    required this.phrases,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage>
    with SingleTickerProviderStateMixin {
  late final List<_QuizQuestion> _questions;
  int _currentIndex = 0;
  int? _selectedOption;
  int _correctCount = 0;
  bool _isFinished = false;
  int _xpGained = 0;

  late AnimationController _feedbackController;
  late Animation<double> _feedbackAnim;

  @override
  void initState() {
    super.initState();
    _questions = _QuizQuestion.generateFrom(widget.phrases);
    _feedbackController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _feedbackAnim = CurvedAnimation(
      parent: _feedbackController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _selectOption(int optionIndex) {
    if (_selectedOption != null) return;
    final isCorrect = optionIndex == _questions[_currentIndex].correctIndex;
    if (isCorrect) {
      unawaited(SfxService.playQuizSuccess());
    } else {
      unawaited(SfxService.playQuizFail());
    }
    setState(() {
      _selectedOption = optionIndex;
      if (isCorrect) _correctCount++;
    });
    _feedbackController.forward(from: 0);
  }

  Future<void> _nextQuestion() async {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedOption = null;
      });
      _feedbackController.reset();
    } else {
      final previousLevel = await ProgressService.getLevelInfo();
      final previousBadges = await ProgressService.getBadges();
      final xp = await ProgressService.completeQuiz(
        widget.chapterNumber,
        widget.lessonTitle,
        _correctCount,
        _questions.length,
      );
      final currentLevel = await ProgressService.getLevelInfo();
      final currentBadges = await ProgressService.getBadges();
      final newUnlockedBadges = currentBadges
          .where((b) => b.unlocked)
          .where(
            (b) => !previousBadges.any((p) => p.id == b.id && p.unlocked),
          )
          .toList();

      if (xp > 0) {
        if (currentLevel.level > previousLevel.level) {
          unawaited(SfxService.playLevelUp());
        } else if (newUnlockedBadges.isNotEmpty) {
          unawaited(SfxService.playBadgeUnlock());
        } else {
          unawaited(SfxService.playXpGain());
        }
      } else if (_correctCount == _questions.length) {
        unawaited(SfxService.playGentleNotification());
      }
      setState(() {
        _isFinished = true;
        _xpGained = xp;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffold,
      body: SafeArea(
        child: _isFinished ? _buildResult() : _buildQuestion(),
      ),
    );
  }

  // ── Question ─────────────────────────────────────────────────────────────

  Widget _buildQuestion() {
    final question = _questions[_currentIndex];
    final progress = (_currentIndex + 1) / _questions.length;

    return Column(
      children: [
        _buildHeader(progress),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Carte phrase allemande
                _QuestionCard(phrase: question.questionPhrase),
                const SizedBox(height: 28),

                const Text(
                  'SÉLECTIONNEZ LA TRADUCTION',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: kInk500,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 14),

                // Options
                ...List.generate(
                  question.options.length,
                  (i) => _OptionButton(
                    label: question.options[i],
                    index: i,
                    selectedIndex: _selectedOption,
                    correctIndex: question.correctIndex,
                    onTap: () => _selectOption(i),
                  ),
                ),

                // Bouton Suivant
                if (_selectedOption != null) ...[
                  const SizedBox(height: 20),
                  FadeTransition(
                    opacity: _feedbackAnim,
                    child: _buildNextButton(),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNextButton() {
    final isLast = _currentIndex >= _questions.length - 1;
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: _nextQuestion,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: kFlagBlack,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                isLast ? 'Voir les résultats' : 'Question suivante',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_rounded,
                  color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader(double progress) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: const BoxDecoration(
        color: kFlagBlack,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.lessonTitle,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${_currentIndex + 1} / ${_questions.length}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white.withValues(alpha: 0.45),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: kFlagGold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: kFlagGold.withValues(alpha: 0.3),
                  ),
                ),
                child: const Text(
                  'Quiz',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: kFlagGold,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withValues(alpha: 0.12),
              valueColor: const AlwaysStoppedAnimation<Color>(kFlagGold),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  // ── Résultat ─────────────────────────────────────────────────────────────

  Widget _buildResult() {
    final score = _correctCount / _questions.length;
    final percent = (score * 100).round();

    final bool isExcellent = percent >= 80;
    final bool isGood = percent >= 50;

    final Color scoreColor = isExcellent
        ? _kSuccess
        : isGood
            ? kFlagGold
            : _kError;
    final String label = isExcellent
        ? 'Excellent !'
        : isGood
            ? 'Bien joué !'
            : 'Continue !';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 16),

          // Score principal
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: kFlagBlack,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                Text(
                  '$percent%',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: scoreColor == _kSuccess ? kFlagGold : scoreColor,
                    fontSize: 56,
                    fontWeight: FontWeight.w900,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                // Bonne/mauvaise réponse breakdown
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _ResultStat(
                        value: '$_correctCount',
                        label: 'Correctes',
                        color: _kSuccess,
                        bg: _kSuccessLight,
                        icon: Icons.check_rounded,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ResultStat(
                        value: '${_questions.length - _correctCount}',
                        label: 'Incorrectes',
                        color: _kError,
                        bg: _kErrorLight,
                        icon: Icons.close_rounded,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // XP gagnés
          if (_xpGained > 0) ...[
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF4D2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: kFlagGold.withValues(alpha: 0.4),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.star_rounded, color: kFlagGold, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    '+$_xpGained XP gagnés',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF7A4A00),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 28),

          // Bouton retour
          SizedBox(
            width: double.infinity,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: kFlagBlack,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back_rounded,
                        color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Retour à la leçon',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
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

// ── Question Card ─────────────────────────────────────────────────────────────

class _QuestionCard extends StatelessWidget {
  final String phrase;

  const _QuestionCard({required this.phrase});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: kSurface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17),
        child: Stack(
          children: [
            Positioned(
              left: 0, top: 0, bottom: 0,
              child: Container(width: 4, color: kFlagBlack),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 16, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('🇩🇪', style: TextStyle(fontSize: 13)),
                      SizedBox(width: 6),
                      Text(
                        'TRADUIRE EN FRANÇAIS',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: kInk500,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    phrase,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: kInk900,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      height: 1.4,
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

// ── Option Button ─────────────────────────────────────────────────────────────

class _OptionButton extends StatelessWidget {
  final String label;
  final int index;
  final int? selectedIndex;
  final int correctIndex;
  final VoidCallback onTap;

  const _OptionButton({
    required this.label,
    required this.index,
    required this.selectedIndex,
    required this.correctIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAnswered = selectedIndex != null;
    final bool isSelected = selectedIndex == index;
    final bool isCorrect = index == correctIndex;

    final bool showSuccess = isAnswered && isCorrect;
    final bool showError = isAnswered && isSelected && !isCorrect;
    final bool isDimmed = isAnswered && !isCorrect && !isSelected;

    Color bg;
    Color border;
    Color badgeBg;
    Color badgeFg;
    Color labelColor;

    if (showSuccess) {
      bg = _kSuccessLight;
      border = _kSuccess;
      badgeBg = _kSuccess;
      badgeFg = Colors.white;
      labelColor = const Color(0xFF14532D);
    } else if (showError) {
      bg = _kErrorLight;
      border = _kError;
      badgeBg = _kError;
      badgeFg = Colors.white;
      labelColor = const Color(0xFF7F1D1D);
    } else {
      bg = Colors.white;
      border = kBorder;
      badgeBg = kInk100;
      badgeFg = kInk600;
      labelColor = kInk900;
    }

    return GestureDetector(
      onTap: isAnswered ? null : onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isDimmed ? 0.42 : 1.0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: border,
              width: showSuccess || showError ? 1.5 : 1.0,
            ),
            boxShadow: isAnswered
                ? []
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: badgeBg,
                  borderRadius: BorderRadius.circular(9),
                ),
                alignment: Alignment.center,
                child: showSuccess
                    ? const Icon(Icons.check_rounded,
                        color: Colors.white, size: 17)
                    : showError
                        ? const Icon(Icons.close_rounded,
                            color: Colors.white, size: 17)
                        : Text(
                            String.fromCharCode(65 + index),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: badgeFg,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: labelColor,
                    fontSize: 14,
                    fontWeight: showSuccess || showError
                        ? FontWeight.w600
                        : FontWeight.w400,
                    height: 1.35,
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

// ── Result Stat ───────────────────────────────────────────────────────────────

class _ResultStat extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final Color bg;
  final IconData icon;

  const _ResultStat({
    required this.value,
    required this.label,
    required this.color,
    required this.bg,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: color,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: color.withValues(alpha: 0.7),
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Question Model ─────────────────────────────────────────────────────────────

class _QuizQuestion {
  final String questionPhrase;
  final String correctAnswer;
  final List<String> options;
  final int correctIndex;

  const _QuizQuestion({
    required this.questionPhrase,
    required this.correctAnswer,
    required this.options,
    required this.correctIndex,
  });

  static List<_QuizQuestion> generateFrom(List<PhraseEntry> phrases) {
    final rng = Random();
    final pool = List<PhraseEntry>.from(phrases)..shuffle(rng);
    final selected = pool.take(min(8, pool.length)).toList();

    return selected.map((entry) {
      final allMeanings = phrases.map((p) => p.meaning).toList();
      final distractors = allMeanings.where((m) => m != entry.meaning).toList()
        ..shuffle(rng);
      final optionCount = min(4, phrases.length);
      final options = <String>[entry.meaning];
      options.addAll(distractors.take(optionCount - 1));
      options.shuffle(rng);
      return _QuizQuestion(
        questionPhrase: entry.phrase,
        correctAnswer: entry.meaning,
        options: options,
        correctIndex: options.indexOf(entry.meaning),
      );
    }).toList();
  }
}
