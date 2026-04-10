import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson5C1Page extends StatelessWidget {
  const Lesson5C1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 1,
      accentColor: kBlue,
      accentLight: kBlueLight,
      title: "Le recueil de données",
      content: "\"Le recueil de données\" signifie \"Die Datenerhebung\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Das Bewusstsein", meaning: "La conscience"),
        PhraseEntry(phrase: "Bewusst / kohärent", meaning: "Conscient / cohérent"),
        PhraseEntry(phrase: "Schläfrig", meaning: "Somnolent"),
        PhraseEntry(phrase: "Bewusstlos", meaning: "Comateux"),
        PhraseEntry(phrase: "Die zeitliche und räumliche Orientierung", meaning: "L'orientation temporo-spatiale"),
        PhraseEntry(phrase: "Wissen Sie, wo Sie sind?", meaning: "Savez-vous où vous êtes ?"),
        PhraseEntry(phrase: "Welcher Tag ist heute?", meaning: "Quel jour sommes-nous aujourd'hui ?"),
        PhraseEntry(phrase: "Die Atmung", meaning: "La respiration"),
        PhraseEntry(phrase: "Haben Sie Atembeschwerden?", meaning: "Avez-vous des difficultés à respirer ?"),
        PhraseEntry(phrase: "Das Sturzrisiko", meaning: "Le risque de chute"),
        PhraseEntry(phrase: "Sind Sie in letzter Zeit gestürzt?", meaning: "Avez-vous fait une chute récemment ?"),
        PhraseEntry(phrase: "Wie können Sie sich bewegen?", meaning: "Comment pouvez-vous vous mobiliser ?"),
        PhraseEntry(phrase: "Eingeschränkte Mobilität", meaning: "Mobilité réduite"),
        PhraseEntry(phrase: "Selbstständig", meaning: "Autonome"),
      ],
    );
  }
}
