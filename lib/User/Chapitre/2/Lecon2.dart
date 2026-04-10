import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson2C2Page extends StatelessWidget {
  const Lesson2C2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 2,
      accentColor: kGreen,
      accentLight: kGreenLight,
      title: "L'évaluation de la douleur",
      content: "\"L'évaluation de la douleur\" signifie \"Die Schmerzeinschätzung\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Haben Sie Schmerzen?", meaning: "Avez-vous mal ?"),
        PhraseEntry(phrase: "Wo haben Sie Schmerzen?", meaning: "Où avez-vous des douleurs ?"),
        PhraseEntry(phrase: "Seit wann haben Sie Schmerzen?", meaning: "Depuis quand avez-vous mal ?"),
        PhraseEntry(phrase: "Können Sie mir die Schmerzen beschreiben?", meaning: "Pouvez-vous me décrire la douleur ?"),
        PhraseEntry(phrase: "Es brennt.", meaning: "Ça me brûle."),
        PhraseEntry(phrase: "Ich spüre einen Druck in der Brust.", meaning: "Ça me serre dans la poitrine."),
        PhraseEntry(phrase: "Es ist ein stechender Schmerz.", meaning: "C'est une douleur piquante."),
        PhraseEntry(phrase: "Es ist ein pulsierender Schmerz.", meaning: "C'est une douleur pulsative."),
        PhraseEntry(phrase: "Es ist ein unerträglicher Schmerz.", meaning: "C'est une douleur insupportable."),
        PhraseEntry(phrase: "Es ist ein akuter Schmerz.", meaning: "C'est une douleur aiguë."),
        PhraseEntry(phrase: "Es ist ein chronischer Schmerz.", meaning: "C'est une douleur permanente/chronique."),
        PhraseEntry(phrase: "Ich gebe Ihnen ein Schmerzmittel.", meaning: "Je vais vous donner un antalgique."),
        PhraseEntry(phrase: "Sie werden bald Erleichterung verspüren.", meaning: "Vous allez rapidement vous sentir mieux."),
        PhraseEntry(phrase: "Ich rufe den Arzt.", meaning: "Je vais prévenir le médecin."),
        PhraseEntry(phrase: "Auf einer Skala von 0 bis 10: Wie stark sind Ihre Schmerzen?", meaning: "Sur une échelle de 0 à 10, combien avez-vous mal ?"),
        PhraseEntry(phrase: "0 bedeutet keine Schmerzen und 10 bedeutet maximale Schmerzen.", meaning: "Sachant que 0 correspond à l'absence de douleur et 10 à la douleur maximale imaginable."),
      ],
    );
  }
}
