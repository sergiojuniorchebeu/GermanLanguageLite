import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson2C4Page extends StatelessWidget {
  const Lesson2C4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 4,
      accentColor: kPeach,
      accentLight: kPeachLight,
      title: "Le matériel",
      content: "\"Le matériel\" signifie \"Das Material\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Die Waschschüssel", meaning: "La bassine"),
        PhraseEntry(phrase: "Der Waschlappen", meaning: "Le gant de toilette"),
        PhraseEntry(phrase: "Das Handtuch", meaning: "La serviette"),
        PhraseEntry(phrase: "Die Seife", meaning: "Le savon"),
        PhraseEntry(phrase: "Die Zahnbürste", meaning: "La brosse à dents"),
        PhraseEntry(phrase: "Die Zahnpasta", meaning: "Le dentifrice"),
        PhraseEntry(phrase: "Die Bettlaken", meaning: "Les draps (m.)"),
        PhraseEntry(phrase: "Der Rollator", meaning: "Le déambulateur"),
        PhraseEntry(phrase: "Der Gehstock", meaning: "La canne"),
      ],
    );
  }
}
