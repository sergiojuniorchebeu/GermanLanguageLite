import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/core/theme/text_styles.dart';

/// AppBar personnalisée v2 — fond kScaffold, propre et moderne.
/// Utilisée sur les pages de chapitres et leçons.
class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showMenu;
  final List<Widget>? actions;

  const CustomAppbar({
    super.key,
    required this.title,
    this.showMenu = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    return Container(
      decoration: const BoxDecoration(
        color: kScaffold,
        border: Border(
          bottom: BorderSide(color: kBorder, width: 1),
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,

        // ── Leading : retour ou menu ────────────────────────────────────
        leading: canPop
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20,
                  color: kInk800,
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
            : showMenu
                ? Builder(
                    builder: (ctx) => IconButton(
                      icon: const Icon(
                        Icons.menu_rounded,
                        size: 24,
                        color: kInk800,
                      ),
                      onPressed: () => Scaffold.of(ctx).openDrawer(),
                    ),
                  )
                : null,

        // ── Titre centré ────────────────────────────────────────────────
        title: Text(
          title,
          style: AppText.h3.copyWith(fontSize: 17),
          overflow: TextOverflow.ellipsis,
        ),

        // ── Actions ─────────────────────────────────────────────────────
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
