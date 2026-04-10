import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson2C7Page extends StatelessWidget {
  const Lesson2C7Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 7,
      accentColor: kBlue,
      accentLight: kBlueLight,
      title: "La glycémie capillaire",
      content: "\"La glycémie capillaire\" signifie \"Die kapillare Blutzuckermessung\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Ich werde Ihren Blutzucker messen.", meaning: "Je vais vous mesurer le taux de sucre."),
        PhraseEntry(phrase: "Ihr Blutzuckerwert ist zu niedrig/normal/zu hoch.", meaning: "Votre taux de sucre est trop bas/normal/trop haut."),
        PhraseEntry(phrase: "Das für die kapillare Blutzuckermessung benötigte Material:", meaning: "Le matériel nécessaire pour une glycémie capillaire :"),
        PhraseEntry(phrase: "Das Blutzuckermessgerät / der Glukometer", meaning: "Le lecteur de glycémie / le glucomètre"),
        PhraseEntry(phrase: "Die Stechhilfe / die Lanzette", meaning: "La lancette"),
        PhraseEntry(phrase: "Der Teststreifen", meaning: "La bandelette"),
      ],
    );
  }
}
