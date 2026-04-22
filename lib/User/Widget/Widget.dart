import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Modèle de donnée — Chapitre
// ─────────────────────────────────────────────────────────────────────────────
class ChapterData {
  final int number;
  final String titleFR;
  final String titleDE;
  final Color accentColor;
  final Color accentLight;
  final IconData icon;
  final Widget? page;
  final bool isComingSoon;
  final String? imagePath; // ← nouveau

  const ChapterData({
    required this.number,
    required this.titleFR,
    required this.titleDE,
    required this.accentColor,
    required this.accentLight,
    required this.icon,
    this.page,
    this.isComingSoon = false,
    this.imagePath, // ← nouveau
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// ChapterCard — Image de fond à gauche avec fondu vers kSurface
// ─────────────────────────────────────────────────────────────────────────────
class ChapterCard extends StatefulWidget {
  final ChapterData chapter;
  final double progress;
  final VoidCallback? onTap;

  const ChapterCard({
    super.key,
    required this.chapter,
    this.progress = 0,
    this.onTap,
  });

  @override
  State<ChapterCard> createState() => _ChapterCardState();
}

class _ChapterCardState extends State<ChapterCard> {
  bool _pressed = false;

  bool get _isDisabled => widget.onTap == null;

  @override
  Widget build(BuildContext context) {
    final accent = _isDisabled ? kInk300 : widget.chapter.accentColor;
    final accentLight = _isDisabled ? kInk100 : widget.chapter.accentLight;
    final progress = widget.progress.clamp(0.0, 1.0);
    final hasImage = widget.chapter.imagePath != null;

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _isDisabled ? null : (_) => setState(() => _pressed = true),
      onTapUp: _isDisabled ? null : (_) => setState(() => _pressed = false),
      onTapCancel: _isDisabled ? null : () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOutCubic,
        child: Container(
          decoration: BoxDecoration(
            color: kSurface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kBorder),
            boxShadow: _pressed || _isDisabled
                ? []
                : [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [

                // ── Bande colorée gauche ──────────────────────────
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(width: 3, color: accent),
                ),

                // ── Image de fond à gauche avec fondu ─────────────
                if (hasImage)
                  Positioned(
                    left: 3, // après la bande colorée
                    top: 0,
                    bottom: 0,
                    width: 100,
                    child: Stack(
                      children: [
                        // Image
                        Positioned.fill(
                          child: Image.asset(
                            widget.chapter.imagePath!,
                            fit: BoxFit.cover,
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                        // Gradient fondu vers kSurface
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  kSurface.withValues(alpha: 0.0),
                                  kSurface.withValues(alpha: 0.55),
                                  kSurface,
                                ],
                                stops: const [0.0, 0.55, 1.0],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // ── Numéro fantôme ────────────────────────────────
                Positioned(
                  right: -4,
                  bottom: 10,
                  child: Text(
                    '${widget.chapter.number}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 72,
                      fontWeight: FontWeight.w900,
                      color: accent.withValues(alpha: 0.07),
                      height: 1,
                    ),
                  ),
                ),

                // ── Contenu ───────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 16, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badge "Kap X" ou "Bientôt" — sans icône
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9, vertical: 4),
                            decoration: BoxDecoration(
                              color: accentLight,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              _isDisabled
                                  ? 'Bientot'
                                  : 'Kap ${widget.chapter.number}',
                              style: AppText.caption.copyWith(
                                color: accent,
                                fontWeight: FontWeight.w700,
                                fontSize: 9.8,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // Titres
                      Text(
                        widget.chapter.titleFR,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.labelL.copyWith(
                          color: kInk900,
                          fontSize: 13.5,
                          height: 1.3,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        widget.chapter.titleDE,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.bodyS.copyWith(
                          color: kInk500,
                          fontStyle: FontStyle.italic,
                          fontSize: 11,
                        ),
                      ),

                      const Spacer(),

                      // Progression
                      Row(
                        children: [
                          Text(
                            _progressLabel(progress),
                            style: AppText.caption.copyWith(
                              color: _isDisabled ? kInk500 : accent,
                              fontSize: 9.6,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          if (!_isDisabled)
                            Icon(Icons.north_east_rounded,
                                color: accent, size: 12),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 5,
                          backgroundColor: accentLight,
                          valueColor: AlwaysStoppedAnimation<Color>(accent),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _progressLabel(double value) {
    if (_isDisabled) return 'Disponible bientot';
    if (value <= 0) return 'A commencer';
    if (value >= 1) return 'Termine';
    return '${(value * 100).round()}% complete';
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// LanguageButton
// ─────────────────────────────────────────────────────────────────────────────
class LanguageButton extends StatefulWidget {
  final String flag;
  final String label;
  final bool isActive;
  final VoidCallback? onPressed;

  const LanguageButton({
    super.key,
    required this.flag,
    required this.label,
    this.isActive = false,
    this.onPressed,
  });

  @override
  State<LanguageButton> createState() => _LanguageButtonState();
}

class _LanguageButtonState extends State<LanguageButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 130),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            color: widget.isActive ? kBlue : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: widget.isActive ? kBlue : kBorder,
              width: widget.isActive ? 1.5 : 1,
            ),
            boxShadow: widget.isActive
                ? [
              BoxShadow(
                color: kBlue.withValues(alpha: 0.22),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.flag, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 7),
              Text(
                widget.label,
                style: AppText.labelM.copyWith(
                  color: widget.isActive ? Colors.white : kInk800,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TaskCard
// ─────────────────────────────────────────────────────────────────────────────
class TaskCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData? leadingIcon;
  final Color? iconColor;
  final Color? iconBackground;
  final VoidCallback? onCardTap;
  final VoidCallback? onTitleTap;
  final VoidCallback? onArrowTap;

  const TaskCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.leadingIcon,
    this.iconColor,
    this.iconBackground,
    this.onCardTap,
    this.onTitleTap,
    this.onArrowTap,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _pressed = false;

  bool get _isDisabled => widget.onCardTap == null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onCardTap,
      onTapDown: _isDisabled ? null : (_) => setState(() => _pressed = true),
      onTapUp: _isDisabled ? null : (_) => setState(() => _pressed = false),
      onTapCancel: _isDisabled ? null : () => setState(() => _pressed = false),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: _isDisabled ? 0.45 : 1.0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          transform: Matrix4.translationValues(_pressed ? 2 : 0, 0, 0),
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: kBorder),
            boxShadow: _pressed || _isDisabled
                ? []
                : [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: _isDisabled
                      ? kInk100
                      : (widget.iconBackground ?? kBlueLight),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  _isDisabled
                      ? Icons.lock_outline_rounded
                      : (widget.leadingIcon ?? Icons.menu_book_rounded),
                  color: _isDisabled ? kInk500 : (widget.iconColor ?? kBlue),
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: AppText.labelM.copyWith(
                        color: kInk900,
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      widget.subtitle,
                      style: AppText.bodyS.copyWith(
                        fontStyle: FontStyle.italic,
                        fontSize: 10.5,
                        color: kInk500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: _isDisabled ? kInk500 : (widget.iconColor ?? kBlue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}