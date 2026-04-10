import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson1C2Page extends StatelessWidget {
  const Lesson1C2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 2,
      accentColor: kGreen,
      accentLight: kGreenLight,
      title: "Les constantes",
      content: "\"Les constantes\" signifie \"Die Basiswerte\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Wie groß sind Sie? Wieviel wiegen Sie?", meaning: "Quelle est votre taille ? Quel est votre poids ?"),
        PhraseEntry(phrase: "Sie sind ... groß.", meaning: "Vous mesurez..."),
        PhraseEntry(phrase: "Sie wiegen ... kg.", meaning: "Vous pesez..."),
        PhraseEntry(phrase: "Ich messe jetzt Ihre Temperatur.", meaning: "Je vais prendre votre température."),
        PhraseEntry(phrase: "Sie haben Fieber.", meaning: "Vous avez de la fièvre."),
        PhraseEntry(phrase: "Sie haben kein Fieber.", meaning: "Vous n'avez pas de fièvre."),
        PhraseEntry(phrase: "Ich messe jetzt Ihren Puls.", meaning: "Je vais prendre votre pouls."),
        PhraseEntry(phrase: "Ihr Puls ist zu langsam / normal / zu hoch.", meaning: "Votre pouls est trop lent / normal / trop rapide."),
        PhraseEntry(phrase: "Ich messe jetzt Ihren Blutdruck.", meaning: "Je vais mesurer votre tension artérielle."),
        PhraseEntry(phrase: "Ihr Blutdruck ist zu niedrig / normal / zu hoch.", meaning: "Votre tension est trop basse / normale / trop haute."),
        PhraseEntry(phrase: "Ihr Blutdruck liegt bei 130/80 (130 zu 80).", meaning: "Votre tension est de 13/8 cm Hg (13 sur 8)."),
        PhraseEntry(phrase: "Ich messe jetzt Ihre Sauerstoffsättigung.", meaning: "Je vais mesurer votre saturation en oxygène."),
        PhraseEntry(phrase: "Der Wert beträgt ... % (Prozent).", meaning: "Les valeurs sont de ... % (pour cent)."),
        PhraseEntry(phrase: "Ich kontrolliere die Urinausscheidung: Menge / Farbe.", meaning: "Je contrôle la durée / quantité / coloration."),
      ],
    );
  }
}
