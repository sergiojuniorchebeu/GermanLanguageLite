import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson1C1Page extends StatelessWidget {
  const Lesson1C1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 1,
      accentColor: kBlue,
      accentLight: kBlueLight,
      title: "Se présenter",
      content: "\"Se présenter\" signifie \"sich vorstellen\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Guten Tag, Frau", meaning: "Bonjour Madame"),
        PhraseEntry(phrase: "Guten Tag, Herr", meaning: "Bonjour Monsieur"),
        PhraseEntry(phrase: "Ich bin Krankenschwester", meaning: "Je suis infirmière"),
        PhraseEntry(phrase: "Ich bin Krankenpfleger", meaning: "Je suis infirmier"),
        PhraseEntry(phrase: "Ich bin Studentin", meaning: "Je suis étudiante"),
        PhraseEntry(phrase: "Ich bin Student", meaning: "Je suis étudiant"),
        PhraseEntry(phrase: "Ich heiße", meaning: "Je m'appelle"),
        PhraseEntry(
          phrase: "Ich werde Ihnen ein paar Fragen stellen, um Ihre Bewerbungsunterlagen zu vervollständigen.",
          meaning: "Je vais vous poser quelques questions pour compléter votre dossier d'admission.",
        ),
      ],
    );
  }
}
