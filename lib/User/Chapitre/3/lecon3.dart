import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson3C3Page extends StatelessWidget {
  const Lesson3C3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 3,
      accentColor: kPurple,
      accentLight: kPurpleLight,
      title: "La nutrition artificielle",
      content: "\"La nutrition artificielle\" signifie \"Die künstliche Ernährung\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Ein nasogastrische Sonde legen", meaning: "Poser une sonde naso-gastrique"),
        PhraseEntry(phrase: "Sich um eine Gastrostomie (PEG) kümmern", meaning: "S'occuper d'une gastronomie (GEP)"),
        PhraseEntry(phrase: "Die Ernährungspumpe benutzen", meaning: "Utiliser la pompe de nutrition"),
        PhraseEntry(phrase: "Den Beutel für enterale Ernährung anschließen", meaning: "Brancher la poche de nutrition entérale"),
        PhraseEntry(phrase: "Parenterale Ernährung", meaning: "Nutrition parentérale"),
        PhraseEntry(phrase: "Enterale Ernährung", meaning: "Nutrition entérale"),
        PhraseEntry(phrase: "Nasogastrische Sonde", meaning: "Sonde naso-gastrique"),
        PhraseEntry(phrase: "Ernährung durch Sonde", meaning: "Alimentation par sonde"),
        PhraseEntry(phrase: "Intravenöse Infusion", meaning: "Perfusion intraveineuse"),
        PhraseEntry(phrase: "Ernährung über intravenöse Zuführung", meaning: "Alimentation par voie intraveineuse"),
      ],
    );
  }
}
