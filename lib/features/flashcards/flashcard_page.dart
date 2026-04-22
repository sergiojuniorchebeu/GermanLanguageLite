import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:projet2/core/services/progress_service.dart';
import 'package:projet2/core/services/sfx_service.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

// Couleurs sémantiques flashcards
const _kKnown = Color(0xFF16A34A);
const _kKnownLight = Color(0xFFDCFCE7);
const _kReview = Color(0xFFDC2626);
const _kReviewLight = Color(0xFFFEE2E2);

// ─────────────────────────────────────────────────────────────────────────────
// FlashcardPage
// ─────────────────────────────────────────────────────────────────────────────
class FlashcardPage extends StatefulWidget {
  final int chapterNumber;
  final String chapterTitle;
  final Color accentColor;
  final Color accentLight;
  final List<PhraseEntry> phrases;

  const FlashcardPage({
    super.key,
    required this.chapterNumber,
    required this.chapterTitle,
    required this.accentColor,
    required this.accentLight,
    required this.phrases,
  });

  @override
  State<FlashcardPage> createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage>
    with TickerProviderStateMixin {
  late List<PhraseEntry> _deck;
  int _currentIndex = 0;
  bool _isFlipped = false;
  int _knownCount = 0;
  int _xpGained = 0;

  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _deck = List<PhraseEntry>.from(widget.phrases)..shuffle(Random());
    _flipController = AnimationController(
      duration: const Duration(milliseconds: 420),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _flip() {
    if (_flipController.isAnimating) return;
    unawaited(SfxService.playFlashcardFlip());
    if (_isFlipped) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    setState(() => _isFlipped = !_isFlipped);
  }

  void _markKnown() {
    unawaited(SfxService.playSoftTap());
    setState(() {
      _knownCount++;
      _isFlipped = false;
    });
    _flipController.value = 0;
    _nextCard();
  }

  void _markReview() {
    unawaited(SfxService.playSoftTap());
    setState(() {
      final card = _deck[_currentIndex];
      _deck.add(card);
      _isFlipped = false;
    });
    _flipController.value = 0;
    _nextCard();
  }

  void _nextCard() {
    if (_currentIndex < _deck.length - 1) {
      setState(() => _currentIndex++);
    } else {
      _finishSession();
    }
  }

  bool get _isFinished => _currentIndex >= _deck.length;

  Future<void> _finishSession() async {
    final previousLevel = await ProgressService.getLevelInfo();
    final previousBadges = await ProgressService.getBadges();
    final xp = await ProgressService.saveFlashcardSession(
      widget.chapterNumber,
      widget.chapterTitle,
      _knownCount,
      widget.phrases.length,
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
    } else {
      unawaited(SfxService.playGentleNotification());
    }

    if (!mounted) return;
    setState(() {
      _xpGained = xp;
      _currentIndex = _deck.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffold,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            if (_isFinished)
              Expanded(child: _buildResult())
            else
              Expanded(child: _buildCardArea()),
          ],
        ),
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    final progress = _isFinished ? 1.0 : _currentIndex / _deck.length;

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
                      widget.chapterTitle,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (!_isFinished)
                      Text(
                        '${_currentIndex + 1} / ${_deck.length}',
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
                  'Flashcards',
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

  // ── Zone carte ───────────────────────────────────────────────────────────

  Widget _buildCardArea() {
    final entry = _deck[_currentIndex];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
      child: Column(
        children: [
          // Indicateur
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: _isFlipped ? Colors.white : kFlagBlack,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: _isFlipped ? kBorder : kFlagBlack,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _isFlipped ? '🇫🇷' : '🇩🇪',
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      _isFlipped
                          ? 'Traduction'
                          : 'Phrase — appuyer pour retourner',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: _isFlipped ? kInk700 : Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Carte retournable
          Expanded(
            child: GestureDetector(
              onTap: _flip,
              child: AnimatedBuilder(
                animation: _flipAnimation,
                builder: (context, child) {
                  final angle = _flipAnimation.value * pi;
                  final isFront = angle <= pi / 2;

                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(angle),
                    child: isFront
                        ? _CardFace(
                            text: entry.phrase,
                            flag: '🇩🇪',
                            isDark: true,
                            isFlipped: false,
                          )
                        : Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()..rotateY(pi),
                            child: _CardFace(
                              text: entry.meaning,
                              flag: '🇫🇷',
                              isDark: false,
                              isFlipped: true,
                            ),
                          ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Boutons action (après retournement)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            child: _isFlipped
                ? Row(
                    key: const ValueKey('actions'),
                    children: [
                      Expanded(
                        child: _ActionButton(
                          label: 'À revoir',
                          icon: Icons.refresh_rounded,
                          bgColor: _kReview,
                          textColor: Colors.white,
                          onTap: _markReview,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _ActionButton(
                          label: 'Je connais',
                          icon: Icons.check_rounded,
                          bgColor: _kKnown,
                          textColor: Colors.white,
                          onTap: _markKnown,
                        ),
                      ),
                    ],
                  )
                : Center(
                    key: const ValueKey('skip'),
                    child: TextButton(
                      onPressed: _nextCard,
                      child: Text(
                        'Passer cette carte →',
                        style: AppText.bodyS.copyWith(color: kInk500),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // ── Résultat ─────────────────────────────────────────────────────────────

  Widget _buildResult() {
    final total = widget.phrases.length;
    final percent = total > 0 ? (_knownCount / total * 100).round() : 0;

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
                const Text(
                  '🎴',
                  style: TextStyle(fontSize: 40),
                ),
                const SizedBox(height: 16),
                Text(
                  '$percent%',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: kFlagGold,
                    fontSize: 56,
                    fontWeight: FontWeight.w900,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'maîtrisé',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _FlashResultStat(
                        value: '$_knownCount',
                        label: 'Connus',
                        color: _kKnown,
                        bg: _kKnownLight,
                        icon: Icons.check_rounded,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _FlashResultStat(
                        value: '${total - _knownCount}',
                        label: 'À revoir',
                        color: _kReview,
                        bg: _kReviewLight,
                        icon: Icons.refresh_rounded,
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

// ── Card Face ─────────────────────────────────────────────────────────────────

class _CardFace extends StatelessWidget {
  final String text;
  final String flag;
  final bool isDark;
  final bool isFlipped;

  const _CardFace({
    required this.text,
    required this.flag,
    required this.isDark,
    required this.isFlipped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? kFlagBlack : kSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.08) : kBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Badge langue
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : kInk100,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(flag, style: const TextStyle(fontSize: 14)),
                const SizedBox(width: 6),
                Text(
                  isDark ? 'Allemand' : 'Français',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.7)
                        : kInk600,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Texte principal
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: isDark ? Colors.white : kInk900,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          if (!isFlipped) ...[
            const SizedBox(height: 36),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.touch_app_rounded,
                  size: 14,
                  color: Colors.white.withValues(alpha: 0.35),
                ),
                const SizedBox(width: 5),
                Text(
                  'Appuyer pour révéler',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white.withValues(alpha: 0.35),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ── Action Button ─────────────────────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color bgColor;
  final Color textColor;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.bgColor,
    required this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: bgColor.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 19, color: textColor),
            const SizedBox(width: 7),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Flash Result Stat ─────────────────────────────────────────────────────────

class _FlashResultStat extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final Color bg;
  final IconData icon;

  const _FlashResultStat({
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
