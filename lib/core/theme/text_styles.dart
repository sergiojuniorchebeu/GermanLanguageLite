import 'package:flutter/material.dart';
import 'colors.dart';

/// Système typographique unifié — Poppins, hiérarchie claire.
class AppText {
  AppText._();

  // ── Titres ─────────────────────────────────────────────────────────────────
  static const h1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: kInk900,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static const h2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: kInk900,
    height: 1.25,
    letterSpacing: -0.3,
  );

  static const h3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: kInk900,
    height: 1.35,
    letterSpacing: -0.2,
  );

  // ── Corps ──────────────────────────────────────────────────────────────────
  static const bodyL = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: kInk700,
    height: 1.55,
  );

  static const bodyM = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: kInk700,
    height: 1.5,
  );

  static const bodyS = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: kInk500,
    height: 1.4,
  );

  // ── Labels ─────────────────────────────────────────────────────────────────
  static const labelL = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: kInk800,
    letterSpacing: 0.1,
  );

  static const labelM = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: kInk800,
    letterSpacing: 0.1,
  );

  static const labelS = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: kInk500,
    letterSpacing: 0.2,
  );

  static const caption = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: kInk500,
    letterSpacing: 0.4,
  );
}
