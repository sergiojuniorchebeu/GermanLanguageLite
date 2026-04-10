import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson4C8Page extends StatelessWidget {
  const Lesson4C8Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 8,
      accentColor: kGreen,
      accentLight: kGreenLight,
      title: "La plaie",
      content: "\"La plaie\" signifie \"Die Wunde\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Ich werde Ihren Verband erneuern.", meaning: "Je vais vous refaire le pansement."),
        PhraseEntry(phrase: "Ich werde jetzt die Nähte / Klammern entfernen.", meaning: "Je vais maintenant retirer les points de suture / les agrafes."),
        PhraseEntry(phrase: "Ich werde die Wunde untersuchen.", meaning: "Je vais observer la plaie."),
        PhraseEntry(phrase: "Sie ist:", meaning: "Elle est :"),
        PhraseEntry(phrase: "trocken", meaning: "sèche"),
        PhraseEntry(phrase: "rot", meaning: "rouge"),
        PhraseEntry(phrase: "entzündlich", meaning: "inflammatoire"),
        PhraseEntry(phrase: "infiziert", meaning: "infectée"),
        PhraseEntry(phrase: "nekrotisch", meaning: "nécrosée"),
        PhraseEntry(phrase: "fibrinös", meaning: "fibrineuse"),
        PhraseEntry(phrase: "granulierend", meaning: "bourgeonnantes"),
        PhraseEntry(phrase: "Der Wundabfluss ist:", meaning: "Les sécrétions (f.) de la plaie sont :"),
        PhraseEntry(phrase: "blutig", meaning: "sanglantes"),
        PhraseEntry(phrase: "serös", meaning: "séreuses"),
        PhraseEntry(phrase: "eitrig", meaning: "purulentes"),
        PhraseEntry(phrase: "Die Wundränder sind:", meaning: "Les berges (f.) de la plaie sont :"),
        PhraseEntry(phrase: "unauffällig / nichts zu berichten", meaning: "sans particularité / R.A.S. (rien à signaler)"),
        PhraseEntry(phrase: "mazeriert", meaning: "macérées"),
      ],
    );
  }
}
