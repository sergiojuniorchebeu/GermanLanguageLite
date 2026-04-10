import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson4C1Page extends StatelessWidget {
  const Lesson4C1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 1,
      accentColor: kBlue,
      accentLight: kBlueLight,
      title: "L'entretien d'accueil",
      content: "\"L'entretien d'accueil\" signifie \"das Aufnahmegespräch\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Wie ist Ihre Situation?", meaning: "Quelle est votre situation ?"),
        PhraseEntry(phrase: "Sind Sie ...?", meaning: "Êtes-vous ... ?"),
        PhraseEntry(phrase: "Verheiratet", meaning: "Marié(e)"),
        PhraseEntry(phrase: "Ledig", meaning: "Célibataire"),
        PhraseEntry(phrase: "In einer Lebensgemeinschaft?", meaning: "En concubinage ?"),
        PhraseEntry(phrase: "In einer Einrichtung?", meaning: "En institution ?"),
        PhraseEntry(phrase: "Haben Sie häusliche Pflege?", meaning: "Avez-vous des soins à domicile ?"),
        PhraseEntry(phrase: "Kann ich jemanden benachrichtigen?", meaning: "Est-ce que je peux prévenir quelqu'un ?"),
        PhraseEntry(phrase: "Wer sind die Personen, die benachrichtigt werden sollen?", meaning: "Qui sont les personnes à prévenir ?"),
      ],
    );
  }
}
