import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson3C4Page extends StatelessWidget {
  const Lesson3C4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 4,
      accentColor: kPeach,
      accentLight: kPeachLight,
      title: "Solliciter le patient",
      content: "\"Solliciter le patient\" signifie \"Den Patienten fördern\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Welche Hilfe brauchen Sie?", meaning: "De quelle aide avez-vous besoin ?"),
        PhraseEntry(phrase: "Brauchen Sie Hilfe beim Anziehen?", meaning: "Avez-vous besoin d'aide pour vous habiller ?"),
        PhraseEntry(phrase: "Brauchen Sie Hilfe beim Hinlegen?", meaning: "Avez-vous besoin d'aide pour vous allonger ?"),
        PhraseEntry(phrase: "Brauchen Sie Hilfe beim Aufstehen?", meaning: "Avez-vous besoin d'aide pour vous lever ?"),
        PhraseEntry(phrase: "Brauchen Sie Hilfe beim Hinsetzen?", meaning: "Avez-vous besoin d'aide pour vous asseoir ?"),
        PhraseEntry(phrase: "Können Sie den Arm hochheben?", meaning: "Pouvez-vous lever le bras ?"),
        PhraseEntry(phrase: "Brauchen Sie den Patientenhalter (den Galgen), um sich zu helfen?", meaning: "Avez-vous besoin de la poignée de traction (le perroquet) pour vous aider ?"),
        PhraseEntry(phrase: "Können Sie sich auf die Seite drehen?", meaning: "Pouvez-vous vous retourner ?"),
        PhraseEntry(phrase: "Wir werden Sie regelmäßig um lagern / nach rechts / auf den Rücken / nach links.", meaning: "Nous allons régulièrement vous retourner sur le côté droit / sur le côté gauche / sur le dos."),
        PhraseEntry(phrase: "Ich werde das Kopfteil hochstellen.", meaning: "Je vais vous remonter la tête du lit."),
        PhraseEntry(phrase: "Ich werde die Seitenteile / das Bettgitter hoch machen.", meaning: "Je vais remonter les barrières du lit."),
      ],
    );
  }
}
