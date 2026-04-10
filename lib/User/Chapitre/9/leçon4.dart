import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson4C9Page extends StatelessWidget {
  const Lesson4C9Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 9,
      accentColor: kPurple,
      accentLight: kPurpleLight,
      title: "La préparation et la distribution des médicaments",
      content: "\"La préparation et la distribution des médicaments\" signifie \"Die Zubereitung und Verteilung von Medikamenten\" en allemand.",
      examples: [
        PhraseEntry(phrase: "das Rezept", meaning: "La prescription médicale"),
        PhraseEntry(phrase: "die Verschreibung", meaning: "La notice"),
        PhraseEntry(phrase: "der Wirkstoff", meaning: "Le composé actif (DCI)"),
        PhraseEntry(phrase: "das Präparat", meaning: "Le nom de spécialité (princeps)"),
        PhraseEntry(phrase: "die Wirkung", meaning: "L'action du médicament (f.)"),
        PhraseEntry(phrase: "die Nebenwirkungen", meaning: "Les effets indésirables (m.)"),
        PhraseEntry(phrase: "die Wechselwirkungen", meaning: "L'interaction médicamenteuse (f.)"),
        PhraseEntry(phrase: "die Medikamentenunverträglichkeit", meaning: "La contre-indication"),
        PhraseEntry(phrase: "die Allergie", meaning: "L'allergie (f.)"),
        PhraseEntry(phrase: "die Dosierung", meaning: "La posologie"),
        PhraseEntry(phrase: "die Zubereitung / die Vorbereitung", meaning: "La préparation"),
        PhraseEntry(phrase: "die Einnahme", meaning: "La prise médicamenteuse"),
        PhraseEntry(phrase: "der Einnahmezeitpunkt", meaning: "L'heure de la prise (f.)"),
        PhraseEntry(phrase: "Morgens nüchtern", meaning: "Le matin à jeun"),
        PhraseEntry(phrase: "Vor dem Essen", meaning: "Avant le repas"),
        PhraseEntry(phrase: "Zwischen den Mahlzeiten", meaning: "Entre les repas"),
        PhraseEntry(phrase: "Während der Mahlzeit", meaning: "Au milieu du repas"),
        PhraseEntry(phrase: "Zweimal täglich", meaning: "Trois fois par jour"),
        PhraseEntry(phrase: "Am Abend", meaning: "Le soir"),
        PhraseEntry(phrase: "Zur Nacht", meaning: "Au coucher"),
      ],
    );
  }
}
