import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:projet2/core/services/progress_service.dart';
import 'package:projet2/core/services/sfx_service.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

// ─────────────────────────────────────────────────────────────────────────────
// FlashcardPage — Révision rapide avec cartes retournables
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
      duration: const Duration(milliseconds: 400),
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
    // Déplace la carte en fin de deck pour la revoir
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
        color: Colors.white,
        border: Border(bottom: BorderSide(color: kBorder)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child:
                    const Icon(Icons.close_rounded, color: kInk500, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Flashcards · ${widget.chapterTitle}',
                      style: AppText.labelM.copyWith(color: kInk700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (!_isFinished)
                      Text(
                        '${_currentIndex + 1} / ${_deck.length}',
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

  // ── Zone carte ───────────────────────────────────────────────────────────
  Widget _buildCardArea() {
    final entry = _deck[_currentIndex];

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      child: Column(
        children: [
          // Instruction
          Text(
            _isFlipped
                ? '🇫🇷 Traduction'
                : '🇩🇪 Phrase — appuyer pour retourner',
            style: AppText.bodyS,
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
                            bgColor: widget.accentLight,
                            borderColor: widget.accentColor.withOpacity(0.3),
                            textColor: kInk900,
                            isFlipped: false,
                          )
                        : Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()..rotateY(pi),
                            child: _CardFace(
                              text: entry.meaning,
                              flag: '🇫🇷',
                              bgColor: Colors.white,
                              borderColor: kBorder,
                              textColor: kInk700,
                              isFlipped: true,
                            ),
                          ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Boutons d'action (visible après retournement)
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _isFlipped ? 1.0 : 0.0,
            child: Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    label: 'À revoir',
                    icon: Icons.refresh_rounded,
                    bgColor: kCoralLight,
                    borderColor: kCoral,
                    textColor: kCoral,
                    onTap: _isFlipped ? _markReview : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ActionButton(
                    label: 'Connu ✓',
                    icon: Icons.check_rounded,
                    bgColor: kGreenLight,
                    borderColor: kGreen,
                    textColor: kGreen,
                    onTap: _isFlipped ? _markKnown : null,
                  ),
                ),
              ],
            ),
          ),

          // Ignorer (quand non retourné)
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _isFlipped ? 0.0 : 1.0,
            child: TextButton(
              onPressed: _isFlipped ? null : _nextCard,
              child: Text(
                'Passer →',
                style: AppText.bodyS.copyWith(color: kInk500),
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

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: widget.accentLight,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Text('🎴', style: TextStyle(fontSize: 44)),
            ),
            const SizedBox(height: 24),
            Text('Session terminée !', style: AppText.h2),
            const SizedBox(height: 8),
            Text(
              '$_knownCount expressions connues sur $total',
              style: AppText.bodyM.copyWith(color: kInk500),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: kBorder),
              ),
              child: Column(
                children: [
                  Text(
                    '$percent%',
                    style: AppText.h1.copyWith(
                      color: widget.accentColor,
                      fontSize: 44,
                    ),
                  ),
                  Text('maîtrisé', style: AppText.bodyS),
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
                child: Text(
                  '+$_xpGained XP gagnés !',
                  style: AppText.labelL.copyWith(color: kInk800),
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
                  '← Retour',
                  style: AppText.labelL.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Card Face ─────────────────────────────────────────────────────────────────
class _CardFace extends StatelessWidget {
  final String text;
  final String flag;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  final bool isFlipped;

  const _CardFace({
    required this.text,
    required this.flag,
    required this.bgColor,
    required this.borderColor,
    required this.textColor,
    required this.isFlipped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(flag, style: const TextStyle(fontSize: 32)),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Text(
              text,
              style: AppText.h3.copyWith(
                color: textColor,
                fontSize: 18,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          if (!isFlipped) ...[
            const SizedBox(height: 32),
            Text(
              'Appuyer pour retourner',
              style: AppText.bodyS,
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
  final Color borderColor;
  final Color textColor;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.bgColor,
    required this.borderColor,
    required this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: textColor),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppText.labelM.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
