import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson2C8Page extends StatelessWidget {
  const Lesson2C8Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 8,
      accentColor: kGreen,
      accentLight: kGreenLight,
      title: "La préparation pré opératoire",
      content: "\"La préparation pré opératoire\" signifie \"Die präoperative Vorbereitung\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Ich werde Sie für die Operation vorbereiten.", meaning: "Je vais vous préparer pour l'opération."),
        PhraseEntry(phrase: "Sie müssen nüchtern bleiben.", meaning: "Il faudra être à jeun."),
        PhraseEntry(phrase: "Sie müssen sich mit einer antiseptischen Seife duschen.", meaning: "Il faudra vous doucher avec un savon antiseptique."),
        PhraseEntry(phrase: "Sie müssen ein OP-Hemd, eine Haube und Thrombosestrümpfe tragen.", meaning: "Il faudra mettre une blouse d'opération, un calot, des bas anti-thrombose."),
        PhraseEntry(phrase: "Sie müssen eine Prämedikation gemäß der ärztlichen Verschreibung einnehmen.", meaning: "Il faudra prendre une prémédication en fonction de la prescription médicale."),
        PhraseEntry(phrase: "Sie müssen Ihre Zahnprothesen, Schmuck und Piercings im Zimmer lassen.", meaning: "Il faudra laisser vos prothèses dentaires, bijoux, piercing en chambre."),
        PhraseEntry(phrase: "Die Rasur wird mit einem elektrischen Rasierer durchgeführt.", meaning: "Le rasage sera fait à l'aide d'une tondeuse électrique."),
      ],
    );
  }
}
