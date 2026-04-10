import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson3C7Page extends StatelessWidget {
  const Lesson3C7Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 7,
      accentColor: kBlue,
      accentLight: kBlueLight,
      title: "Les valeurs sanguines",
      content: "\"Les valeurs sanguines\" signifie \"Die Blutwerte\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Wir werden die folgenden Blutwerte überprüfen.", meaning: "Nous allons vérifier les valeurs sanguines suivantes."),
        PhraseEntry(phrase: "Das Blutbild", meaning: "La NFS"),
        PhraseEntry(phrase: "Die Leukozyten", meaning: "Les leucocytes (m.)"),
        PhraseEntry(phrase: "Das Hämoglobin", meaning: "L'hémoglobine (f.)"),
        PhraseEntry(phrase: "Die Blutplättchen / Thrombozyten", meaning: "Les plaquettes (f.)"),
        PhraseEntry(phrase: "Das Ionogramm", meaning: "Le ionogramme"),
        PhraseEntry(phrase: "Das Natrium", meaning: "Le sodium"),
        PhraseEntry(phrase: "Das Kalium", meaning: "Le potassium"),
        PhraseEntry(phrase: "Der Harnstoff", meaning: "L'urée (f.)"),
        PhraseEntry(phrase: "Das Kreatinin", meaning: "La créatinine"),
        PhraseEntry(phrase: "Das Cholesterin", meaning: "Le cholestérol"),
        PhraseEntry(phrase: "Die Triglyzeride", meaning: "Les triglycérides (m.)"),
        PhraseEntry(phrase: "Die Gerinnung", meaning: "La coagulation"),
        PhraseEntry(phrase: "Quick-Wert", meaning: "TQ"),
        PhraseEntry(phrase: "INR", meaning: "INR"),
        PhraseEntry(phrase: "PTT", meaning: "TCA"),
      ],
    );
  }
}
