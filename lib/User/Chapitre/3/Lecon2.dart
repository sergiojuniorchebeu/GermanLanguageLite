import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson2C3Page extends StatelessWidget {
  const Lesson2C3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 3,
      accentColor: kPurple,
      accentLight: kPurpleLight,
      title: "Les troubles digestifs",
      content: "\"Les troubles digestifs\" signifie \"Die Verdauungsprobleme\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Die Mangelernährung", meaning: "La dénutrition"),
        PhraseEntry(phrase: "Der Appetitverlust", meaning: "La perte d'appétit"),
        PhraseEntry(phrase: "Die Schluckstörung", meaning: "Le trouble de la déglutition"),
        PhraseEntry(phrase: "Die Stuhlgangstörung", meaning: "Le trouble du transit"),
        PhraseEntry(phrase: "Die Nahrungsmittelunverträglichkeit", meaning: "L'intolérance alimentaire"),
        PhraseEntry(phrase: "Die Stoffwechselstörung", meaning: "Le trouble métabolique"),
        PhraseEntry(phrase: "Haben Sie Schmerzen?", meaning: "Est-ce que vous avez des douleurs ?"),
        PhraseEntry(phrase: "Haben Sie Übelkeit?", meaning: "Avez-vous des nausées ?"),
        PhraseEntry(phrase: "Haben Sie Erbrechen?", meaning: "Avez-vous des vomissements ?"),
        PhraseEntry(phrase: "Haben Sie Sodbrennen?", meaning: "Est-ce que vous avez des brûlures d'estomac ?"),
        PhraseEntry(phrase: "Haben Sie Appetitlosigkeit?", meaning: "Est-ce que vous avez une perte d'appétit ?"),
        PhraseEntry(phrase: "Haben Sie Blähungen?", meaning: "Avez-vous des ballonnements ?"),
        PhraseEntry(phrase: "Haben Sie Durchfall?", meaning: "Avez-vous de la diarrhée ?"),
        PhraseEntry(phrase: "Haben Sie Verstopfung?", meaning: "Avez-vous de la constipation ?"),
        PhraseEntry(phrase: "Haben Sie Bauchschmerzen?", meaning: "Avez-vous des douleurs abdominales ?"),
        PhraseEntry(phrase: "Haben Sie Blähungen?", meaning: "Est-ce que vous avez des gaz ?"),
        PhraseEntry(phrase: "Haben Sie Darmkrämpfe?", meaning: "Avez-vous des crampes intestinales ?"),
        PhraseEntry(phrase: "Haben Sie Magen-Reflux?", meaning: "Est-ce que vous avez des reflux gastriques ?"),
        PhraseEntry(phrase: "Haben Sie Verdauungsprobleme?", meaning: "Avez-vous des problèmes de digestion ?"),
      ],
    );
  }
}
