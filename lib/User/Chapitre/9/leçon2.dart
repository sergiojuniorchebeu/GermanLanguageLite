import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson2C9Page extends StatelessWidget {
  const Lesson2C9Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 9,
      accentColor: kPurple,
      accentLight: kPurpleLight,
      title: "La sonde urinaire",
      content: "\"La sonde urinaire\" signifie \"Der Blasenkatheter\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Ich werde Ihnen einen Blasenkatheter legen.", meaning: "Je vais vous poser une sonde urinaire."),
        PhraseEntry(phrase: "das Katheterset", meaning: "le set de sondage"),
        PhraseEntry(phrase: "der Urinbeutel", meaning: "le collecteur à urine"),
        PhraseEntry(phrase: "die sterilen Abdecktücher", meaning: "les champs stériles"),
        PhraseEntry(phrase: "die sterilen Handschuhe", meaning: "les gants stériles"),
      ],
    );
  }
}
