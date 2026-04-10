import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson1C7Page extends StatelessWidget {
  const Lesson1C7Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 7,
      accentColor: kBlue,
      accentLight: kBlueLight,
      title: "La prise de sang",
      content: "\"La prise de sang\" signifie \"Die Blutabnahme\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Ich werde Ihnen Blut abnehmen.", meaning: "Je vais vous faire une prise de sang."),
        PhraseEntry(phrase: "Das für die Blutabnahme benötigte Material", meaning: "Le matériel nécessaire pour prise de sang"),
        PhraseEntry(phrase: "Der Stauschlauch", meaning: "Le garrot"),
        PhraseEntry(phrase: "Die Handschuhe", meaning: "Les gants"),
        PhraseEntry(phrase: "Ein Antiseptikum", meaning: "Un antiseptique"),
        PhraseEntry(phrase: "Die Röhrchen", meaning: "Les tubes"),
        PhraseEntry(phrase: "Eine Nadel", meaning: "Une aiguille"),
        PhraseEntry(phrase: "Ein Nadelbehälter (der Septobox)", meaning: "Un collecteur à aiguilles (le septobox)"),
        PhraseEntry(phrase: "Ein Pflaster", meaning: "Un pansement"),
        PhraseEntry(phrase: "Die Nierenschale", meaning: "Le haricot"),
        PhraseEntry(phrase: "Ich werde Ihnen einen Stauschlauch anlegen.", meaning: "Je vais vous poser un garrot."),
        PhraseEntry(phrase: "Können Sie die Faust schließen?", meaning: "Pouvez-vous fermer le poing?"),
        PhraseEntry(phrase: "Es wird ein wenig stechen.", meaning: "Ça va piquer un peu."),
      ],
    );
  }
}
