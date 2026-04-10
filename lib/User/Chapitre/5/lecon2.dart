import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson2C5Page extends StatelessWidget {
  const Lesson2C5Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 5,
      accentColor: kCoral,
      accentLight: kCoralLight,
      title: "L'écoute des plaintes",
      content: "\"L'écoute des plaintes\" signifie \"Das Zuhören der Beschwerden\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Der Patient klagt über...", meaning: "Le patient se plaint de..."),
        PhraseEntry(phrase: "Juckreiz (m.)", meaning: "Prurit (m.)"),
        PhraseEntry(phrase: "Tinnitus (m.)", meaning: "Accouphène (m.)"),
        PhraseEntry(phrase: "Schlafstörungen (m.) / Schlaflosigkeit (f.)", meaning: "Troubles du sommeil (m.) / Insomnie (f.)"),
        PhraseEntry(phrase: "Krämpfe (f.)", meaning: "Crampe (f.)"),
        PhraseEntry(phrase: "Müdigkeit (f.)", meaning: "Fatigue (f.)"),
        PhraseEntry(phrase: "Palpitationen (f.)", meaning: "Palpitations (f.)"),
        PhraseEntry(phrase: "Befinden sich schlecht (f.)", meaning: "Sensation de malaise (f.)"),
        PhraseEntry(phrase: "Schwindel (m.)", meaning: "Vertige (m.)"),
        PhraseEntry(phrase: "Kopfschmerzen (f.)", meaning: "Céphalées (f.)"),
      ],
    );
  }
}
