import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson1C3Page extends StatelessWidget {
  const Lesson1C3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 3,
      accentColor: kPurple,
      accentLight: kPurpleLight,
      title: "Les différents régimes",
      content: "\"Les différents régimes\" signifie \"Die verschiedenen Diäten\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Können Sie alles essen/trinken?", meaning: "Est-ce que vous pouvez tout manger/boire ?"),
        PhraseEntry(phrase: "Eine Normalkost", meaning: "Un régime normal"),
        PhraseEntry(phrase: "Eine leichte Kost", meaning: "Un régime léger"),
        PhraseEntry(phrase: "Eine pürierte Kost", meaning: "Un régime mixé"),
        PhraseEntry(phrase: "Eine salzarme Diät", meaning: "Un régime sans sel"),
        PhraseEntry(phrase: "Eine Diabetesdiät", meaning: "Un régime diabétique"),
        PhraseEntry(phrase: "Eine vegetarische / vegane Ernährung", meaning: "Un régime végétarien / vegan"),
        PhraseEntry(phrase: "Eine eiweißreiche Diät", meaning: "Un régime hyperprotéiné"),
        PhraseEntry(phrase: "Eine glutenfreie Diät", meaning: "Un régime sans gluten"),
        PhraseEntry(phrase: "Eine Schweinefleisch-freie Kost", meaning: "Un régime sans porc"),
        PhraseEntry(phrase: "Eine ballaststoffarme Diät", meaning: "Un régime sans résidu"),
        PhraseEntry(phrase: "Haben Sie eine spezielle Diät?", meaning: "Avez-vous un régime alimentaire spécifique ?"),
        PhraseEntry(phrase: "Haben Sie eine Zahnprothese?", meaning: "Avez-vous une prothèse dentaire ?"),
      ],
    );
  }
}
