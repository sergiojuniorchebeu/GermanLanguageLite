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

  const ChapterData({
    required this.number,
    required this.titleFR,
    required this.titleDE,
    required this.accentColor,
    required this.accentLight,
    required this.icon,
    this.page,
    this.isComingSoon = false,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// ChapterCard — Redesign v3 (Dribbble-inspired)
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
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _isDisabled ? null : (_) => setState(() => _pressed = true),
      onTapUp: _isDisabled ? null : (_) => setState(() => _pressed = false),
      onTapCancel: _isDisabled ? null : () => setState(() => _pressed = false),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: _isDisabled ? 0.48 : 1.0,
        child: AnimatedScale(
          scale: _pressed ? 0.97 : 1.0,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 190),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: kBorder),
              boxShadow: _pressed || _isDisabled
                  ? []
                  : [
                BoxShadow(
                  color: widget.chapter.accentColor.withOpacity(0.12),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  // ── Numéro en filigrane ──────────────────────────────────
                  Positioned(
                    bottom: -12,
                    right: -4,
                    child: Text(
                      '${widget.chapter.number}',
                      style: TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.w800,
                        color: _isDisabled
                            ? kInk900.withOpacity(0.04)
                            : widget.chapter.accentColor.withOpacity(0.06),
                        height: 1,
                      ),
                    ),
                  ),

                  // ── Barre d'accent colorée en haut ───────────────────────
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 3,
                      color: _isDisabled ? kInk500 : widget.chapter.accentColor,
                    ),
                  ),

                  // ── Contenu principal ────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 18, 14, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Icône + badge numéro
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 46,
                              height: 46,
                              decoration: BoxDecoration(
                                color: _isDisabled
                                    ? kInk100
                                    : widget.chapter.accentLight,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Icon(
                                _isDisabled
                                    ? Icons.lock_outline_rounded
                                    : widget.chapter.icon,
                                color: _isDisabled
                                    ? kInk500
                                    : widget.chapter.accentColor,
                                size: 22,
                              ),
                            ),
                            _ChapterBadge(
                              label: _isDisabled
                                  ? 'Bientôt'
                                  : 'Ch.${widget.chapter.number}',
                              color: _isDisabled
                                  ? kInk500
                                  : widget.chapter.accentColor,
                              bgColor: _isDisabled
                                  ? kInk100
                                  : widget.chapter.accentLight,
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        // Titre FR
                        Text(
                          widget.chapter.titleFR,
                          style: AppText.labelM.copyWith(
                            fontSize: 12.5,
                            height: 1.38,
                            color: kInk900,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 3),

                        // Titre DE
                        Text(
                          widget.chapter.titleDE,
                          style: AppText.bodyS.copyWith(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: kInk500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 14),

                        // Barre de progression
                        _ProgressSection(
                          color: _isDisabled
                              ? kInk500
                              : widget.chapter.accentColor,
                          trackColor: _isDisabled
                              ? kInk100
                              : widget.chapter.accentLight,
                          value: widget.progress,
                          isDisabled: _isDisabled,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChapterBadge extends StatelessWidget {
  final String label;
  final Color color;
  final Color bgColor;

  const _ChapterBadge({
    required this.label,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: AppText.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 10,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _ProgressSection extends StatelessWidget {
  final Color color;
  final Color trackColor;
  final double value;
  final bool isDisabled;

  const _ProgressSection({
    required this.color,
    required this.trackColor,
    required this.value,
    required this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    final label = isDisabled
        ? 'Non disponible'
        : value == 0.0
        ? 'Non commencé'
        : value >= 1.0
        ? 'Complété ✓'
        : '${(value * 100).round()}%';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppText.caption.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: trackColor,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 5,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// LanguageButton — Redesign v3 : pill arrondi style switcher
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
                color: kBlue.withOpacity(0.22),
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
// TaskCard — Redesign v3 : hover translate + icône thématique
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
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Icône
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
                  color: _isDisabled
                      ? kInk500
                      : (widget.iconColor ?? kBlue),
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),

              // Textes
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

              // Flèche
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: _isDisabled
                    ? kInk500
                    : (widget.iconColor ?? kBlue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}