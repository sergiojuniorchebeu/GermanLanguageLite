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
// ChapterCard — Card grille 2 colonnes (redesign v2)
// ─────────────────────────────────────────────────────────────────────────────
class ChapterCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final bool isDisabled = onTap == null;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isDisabled ? 0.52 : 1.0,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kBorder),
            boxShadow: [
              BoxShadow(
                color: chapter.accentColor.withOpacity(isDisabled ? 0 : 0.08),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── En-tête : icône + badge numéro ──────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: isDisabled ? kInk100 : chapter.accentLight,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Icon(
                      isDisabled ? Icons.lock_outline_rounded : chapter.icon,
                      color: isDisabled ? kInk500 : chapter.accentColor,
                      size: 22,
                    ),
                  ),
                  _ChapterBadge(
                    label: isDisabled ? 'Bientôt' : 'Ch.${chapter.number}',
                    color: isDisabled ? kInk500 : chapter.accentColor,
                    bgColor: isDisabled ? kInk100 : chapter.accentLight,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // ── Titre FR ────────────────────────────────────────────────
              Text(
                chapter.titleFR,
                style: AppText.labelM.copyWith(
                  fontSize: 12,
                  height: 1.35,
                  color: kInk900,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 3),

              // ── Titre DE ────────────────────────────────────────────────
              Text(
                chapter.titleDE,
                style: AppText.bodyS.copyWith(
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                  color: kInk500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const Spacer(),

              // ── Barre de progression ─────────────────────────────────────
              _ProgressSection(
                color: isDisabled ? kInk500 : chapter.accentColor,
                trackColor: isDisabled ? kInk100 : chapter.accentLight,
                value: progress,
                isDisabled: isDisabled,
              ),
            ],
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: AppText.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
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
// LanguageButton — Bouton sélecteur de langue (conservé, redesigné)
// ─────────────────────────────────────────────────────────────────────────────
class LanguageButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? kBlue : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? kBlue : kBorder,
            width: isActive ? 1.5 : 1,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: kBlue.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  )
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(flag, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppText.labelM.copyWith(
                color: isActive ? Colors.white : kInk800,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TaskCard — Conservé pour les pages de leçons (list view)
// ─────────────────────────────────────────────────────────────────────────────
class TaskCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onCardTap;
  final VoidCallback? onTitleTap;
  final VoidCallback? onArrowTap;

  const TaskCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.onCardTap,
    this.onTitleTap,
    this.onArrowTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onCardTap == null;

    return GestureDetector(
      onTap: onCardTap,
      child: Opacity(
        opacity: isDisabled ? 0.5 : 1.0,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: kBorder),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: isDisabled ? kInk100 : kBlueLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isDisabled
                      ? Icons.lock_outline_rounded
                      : Icons.menu_book_rounded,
                  color: isDisabled ? kInk500 : kBlue,
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppText.labelM.copyWith(color: kInk900),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: AppText.bodyS.copyWith(
                        fontStyle: FontStyle.italic,
                        fontSize: 11,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: isDisabled ? kInk500 : kBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
