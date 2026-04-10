import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson2C10Page extends StatelessWidget {
  const Lesson2C10Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 10,
      accentColor: kCoral,
      accentLight: kCoralLight,
      title: "La conduite à tenir chez l'adulte",
      content: "\"La conduite à tenir chez l'adulte\" signifie \"Das Verhalten bei Erwachsenen\" en allemand. Ce guide décrit l'algorithme des situations d'urgence.",
      examples: [
        PhraseEntry(phrase: "Kontrolle von :", meaning: "Contrôle de :"),
        PhraseEntry(phrase: "Bewusstsein", meaning: "la conscience"),
        PhraseEntry(phrase: "Atmung", meaning: "la respiration"),
        PhraseEntry(phrase: "Kreislauf/Puls", meaning: "la circulation/pouls"),
        PhraseEntry(phrase: "Notruf", meaning: "Numéros d'urgence"),
        PhraseEntry(phrase: "Respiration et pouls présents = Atmung und Herzschlag vorhanden", meaning: "Inconscience : Bewusstsein gestört"),
        PhraseEntry(phrase: "Stabile Seitenlage", meaning: "Position latérale de sécurité (PLS)"),
        PhraseEntry(phrase: "Atemstillstand", meaning: "Arrêt respiratoire"),
        PhraseEntry(phrase: "Beatmung", meaning: "Ventilation"),
        PhraseEntry(phrase: "Herz-Kreislauf-Stillstand", meaning: "Arrêt cardio-respiratoire"),
        PhraseEntry(phrase: "Herz-Lungen-Wiederbelebung", meaning: "Réanimation cardio-pulmonaire"),
        PhraseEntry(phrase: "Frequenz : 100 - 120/min", meaning: "Fréquence : 100 - 120/min"),
        PhraseEntry(phrase: "Eindringtiefe : 5 - 6 cm", meaning: "Profondeur : 5 - 6 cm"),
      ],
    );
  }
}
