import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson1C5Page extends StatelessWidget {
  const Lesson1C5Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 5,
      accentColor: kCoral,
      accentLight: kCoralLight,
      title: "L'observation",
      content: "\"L'observation\" signifie \"Die Beobachtung\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Eine Blässe", meaning: "Une pâleur"),
        PhraseEntry(phrase: "Eine Zyanose", meaning: "Une cyanose"),
        PhraseEntry(phrase: "Eine Rötung", meaning: "Une rougeur"),
        PhraseEntry(phrase: "Gelbsucht (f.) / Ikterus (m.)", meaning: "Un ictère"),
        PhraseEntry(phrase: "Schweiß (m.)", meaning: "De la sueur"),
        PhraseEntry(phrase: "Eine Blutung", meaning: "Un saignement"),
        PhraseEntry(phrase: "Husten (m.)", meaning: "Une toux"),
        PhraseEntry(phrase: "Dyspnoe (f.) / Atemnot (f.)", meaning: "Une dyspnée / une détresse respiratoire"),
        PhraseEntry(phrase: "Eine Unterkühlung / eine Hypothermie", meaning: "Une hypothermie"),
        PhraseEntry(phrase: "Unruhe (f.)", meaning: "Une agitation"),
        PhraseEntry(phrase: "Eine Verwirrtheit", meaning: "Une confusion"),
        PhraseEntry(phrase: "Ein Delir", meaning: "Des hallucinations (f.)"),
        PhraseEntry(phrase: "Eine Lähmung / eine Halbseitenlähmung", meaning: "Une paralysie / une hémiplégie"),
        PhraseEntry(phrase: "Eine Schläfrigkeit / eine Somnolenz", meaning: "Une somnolence"),
        PhraseEntry(phrase: "Ein Zittern", meaning: "Un tremblement"),
        PhraseEntry(phrase: "Eine Inhalation", meaning: "Une inhalation"),
        PhraseEntry(phrase: "Eine Fehlschlucken", meaning: "Une fausse route"),
        PhraseEntry(phrase: "Ein Unwohlsein / ein Vasovagale", meaning: "Un malaise / un malaise vagal"),
        PhraseEntry(phrase: "Ein Bewusstseinsverlust / eine Ohnmacht", meaning: "Une perte de connaissance / une inconscience"),
      ],
    );
  }
}
