import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson1C9Page extends StatelessWidget {
  const Lesson1C9Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 9,
      accentColor: kPurple,
      accentLight: kPurpleLight,
      title: "La perfusion",
      content: "\"La perfusion\" signifie \"Die Infusion\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Ich werde überprüfen, was der Arzt verschrieben hat. (= die ärztliche Verordnung)", meaning: "Je vais vérifier ce que le médecin a prescrit. (= la prescription médicale)"),
        PhraseEntry(phrase: "Ich werde Ihnen einen Venenkatheter legen.", meaning: "Je vais vous poser un cathéter veineux."),
        PhraseEntry(phrase: "Ich werde die Infusionsflasche anschließen / wechseln.", meaning: "Je vais poser / changer le flacon de perfusion."),
        PhraseEntry(phrase: "Ich werde die Infusionsleitung entlüften.", meaning: "Je vais purger la tubulure."),
        PhraseEntry(phrase: "die Tropfkammer", meaning: "la chambre compte-goutte"),
        PhraseEntry(phrase: "das Stellrädchen", meaning: "la molette"),
        PhraseEntry(phrase: "Der Arzt wird Ihnen einen zentralen Venenkatheter (ZVK) / einen arteriellen Katheter legen.", meaning: "Le médecin va vous poser un cathéter central (KTC) / un cathéter artériel."),
        PhraseEntry(phrase: "Ich brauche...", meaning: "Il me faut..."),
        PhraseEntry(phrase: "Ein Dreiwegehahn", meaning: "Un robinet 3 voies"),
        PhraseEntry(phrase: "Eine Verlängerung", meaning: "un prolongateur"),
        PhraseEntry(phrase: "Ein Verschluss", meaning: "un bouchon"),
        PhraseEntry(phrase: "Ein Infusionsleiste", meaning: "une rampe"),
        PhraseEntry(phrase: "Ein Infusionsständer", meaning: "une potence"),
        PhraseEntry(phrase: "Ein Durchflussmesser", meaning: "un débimètre"),
        PhraseEntry(phrase: "Eine elektrische Spritzenpumpe", meaning: "un pousse seringue électrique (PSE)"),
      ],
    );
  }
}
