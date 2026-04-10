import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:projet2/core/services/progress_service.dart';
import 'package:projet2/core/services/sfx_service.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

// ─────────────────────────────────────────────────────────────────────────────
// QuizPage — QCM généré dynamiquement depuis les PhraseEntry du cours
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
    final question = _questions[_currentIndex];
    final isCorrect = optionIndex == question.correctIndex;
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
          .where((badge) => badge.unlocked)
          .where(
            (badge) => !previousBadges.any(
              (previous) => previous.id == badge.id && previous.unlocked,
            ),
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

  // ── Résultat final ────────────────────────────────────────────────────────
  Widget _buildResult() {
    final score = _correctCount / _questions.length;
    final percent = (score * 100).round();
    final emoji = percent >= 80
        ? '🎉'
        : percent >= 50
            ? '👍'
            : '💪';
    final label = percent >= 80
        ? 'Excellent !'
        : percent >= 50
            ? 'Bien joué !'
            : 'Continue d\'apprendre !';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: widget.accentLight,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(emoji, style: const TextStyle(fontSize: 48)),
            ),
            const SizedBox(height: 28),
            Text('Quiz terminé !', style: AppText.h2),
            const SizedBox(height: 8),
            Text(label, style: AppText.bodyM.copyWith(color: kInk500)),
            const SizedBox(height: 32),
            // Score
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: kBorder),
              ),
              child: Column(
                children: [
                  Text(
                    '$_correctCount / ${_questions.length}',
                    style: AppText.h1.copyWith(
                      color: widget.accentColor,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('bonnes réponses', style: AppText.bodyS),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: score,
                      backgroundColor: widget.accentLight,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(widget.accentColor),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),
            if (_xpGained > 0) ...[
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: kYellowLight,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: kYellow),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('⚡', style: TextStyle(fontSize: 20)),
                    const SizedBox(width: 8),
                    Text(
                      '+$_xpGained XP gagnés !',
                      style: AppText.labelL.copyWith(color: kInk800),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 36),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.accentColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  '← Retour à la leçon',
                  style: AppText.labelL.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Question ─────────────────────────────────────────────────────────────
  Widget _buildQuestion() {
    final question = _questions[_currentIndex];
    final progress = (_currentIndex + 1) / _questions.length;

    return Column(
      children: [
        // Header
        _buildHeader(progress),
        const SizedBox(height: 24),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Phrase en allemand
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: widget.accentLight,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: widget.accentColor.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('🇩🇪', style: TextStyle(fontSize: 16)),
                          const SizedBox(width: 8),
                          Text(
                            'Traduire en français :',
                            style: AppText.labelS.copyWith(
                              color: widget.accentColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        question.questionPhrase,
                        style: AppText.h3.copyWith(
                          color: kInk900,
                          fontSize: 17,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Sélectionnez la traduction :',
                  style: AppText.labelS.copyWith(color: kInk500),
                ),
                const SizedBox(height: 12),

                // Options
                ...List.generate(
                  question.options.length,
                  (i) => _OptionButton(
                    label: question.options[i],
                    index: i,
                    selectedIndex: _selectedOption,
                    correctIndex: question.correctIndex,
                    accentColor: widget.accentColor,
                    onTap: () => _selectOption(i),
                  ),
                ),

                // Bouton Suivant
                if (_selectedOption != null) ...[
                  const SizedBox(height: 24),
                  FadeTransition(
                    opacity: _feedbackAnim,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _nextQuestion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.accentColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          _currentIndex < _questions.length - 1
                              ? 'Question suivante →'
                              : 'Voir les résultats →',
                          style: AppText.labelL.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(double progress) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(bottom: BorderSide(color: kBorder)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.close_rounded,
                  color: kInk500,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quiz · ${widget.lessonTitle}',
                      style: AppText.labelM.copyWith(color: kInk700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${_currentIndex + 1} / ${_questions.length}',
                      style: AppText.labelS,
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: widget.accentLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Ch.${widget.chapterNumber}',
                  style: AppText.caption.copyWith(
                    color: widget.accentColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: kInk100,
              valueColor: AlwaysStoppedAnimation<Color>(widget.accentColor),
              minHeight: 5,
            ),
          ),
        ],
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
  final Color accentColor;
  final VoidCallback onTap;

  const _OptionButton({
    required this.label,
    required this.index,
    required this.selectedIndex,
    required this.correctIndex,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAnswered = selectedIndex != null;
    final bool isSelected = selectedIndex == index;
    final bool isCorrect = index == correctIndex;

    Color bgColor = Colors.white;
    Color borderColor = kBorder;
    Color textColor = kInk900;
    Widget? trailingIcon;

    if (isAnswered) {
      if (isCorrect) {
        bgColor = kGreenLight;
        borderColor = kGreen;
        textColor = kInk900;
        trailingIcon =
            const Icon(Icons.check_circle_rounded, color: kGreen, size: 20);
      } else if (isSelected) {
        bgColor = kCoralLight;
        borderColor = kCoral;
        textColor = kInk900;
        trailingIcon =
            const Icon(Icons.cancel_rounded, color: kCoral, size: 20);
      }
    }

    return GestureDetector(
      onTap: isAnswered ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isAnswered && isCorrect
                    ? kGreen
                    : isAnswered && isSelected
                        ? kCoral
                        : kInk100,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                String.fromCharCode(65 + index), // A, B, C, D
                style: AppText.labelS.copyWith(
                  color: isAnswered && (isCorrect || isSelected)
                      ? Colors.white
                      : kInk500,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: AppText.bodyM.copyWith(color: textColor),
              ),
            ),
            if (trailingIcon != null) trailingIcon,
          ],
        ),
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
    // Limiter à 8 questions max
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

      final correctIndex = options.indexOf(entry.meaning);

      return _QuizQuestion(
        questionPhrase: entry.phrase,
        correctAnswer: entry.meaning,
        options: options,
        correctIndex: correctIndex,
      );
    }).toList();
  }
}
