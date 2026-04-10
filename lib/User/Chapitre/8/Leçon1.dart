import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson1C8Page extends StatelessWidget {
  const Lesson1C8Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 8,
      accentColor: kGreen,
      accentLight: kGreenLight,
      title: "L'anesthésie",
      content: "\"L'anesthésie\" signifie \"Die Anästhesie\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Ich gebe Ihnen das Formular für die Anästhesie/ die Operation, und Sie müssen es sorgfältig lesen.", meaning: "Je vous remets le formulaire pour l'anesthésie/ l'opération et il faudra le lire consciencieusement."),
        PhraseEntry(phrase: "Sie werden Folgendes haben:", meaning: "Vous allez avoir :"),
        PhraseEntry(phrase: "Eine lokale Anästhesie", meaning: "Une anesthésie locale (AL)"),
        PhraseEntry(phrase: "Eine Periduralanästhesie", meaning: "Une anesthésie péridurale"),
        PhraseEntry(phrase: "Eine Spinalanästhesie", meaning: "Une rachi-anesthésie"),
        PhraseEntry(phrase: "Für die Allgemeinanästhesie", meaning: "Pour l'anesthésie générale"),
        PhraseEntry(phrase: "Für die Allgemeinanästhesie wird eine Mischung aus Hypnotikum, Analgetikum (und Curare) verwendet.", meaning: "Pour l'anesthésie générale on utilise un mélange d'hypnotique, d'antalgique (et de curare)."),
        PhraseEntry(phrase: "Der Arzt wird Ihnen einen Intubationsschlauch/ eine Larynxmaske legen.", meaning: "Le médecin va vous poser une sonde d'intubation/ un masque laryngé."),
      ],
    );
  }
}
