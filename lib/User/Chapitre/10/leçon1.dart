import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson1C10Page extends StatelessWidget {
  const Lesson1C10Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 10,
      accentColor: kCoral,
      accentLight: kCoralLight,
      title: "Les différents étiologies de situations d'urgence",
      content: "\"Les différents étiologies de situations d'urgence\" signifie \"Die verschiedenen Ätiologien von Notfallsituationen\" en allemand. Ce guide décrit les causes des urgences médicales et leur classification.",
      examples: [
        PhraseEntry(phrase: "Die Atmung", meaning: "Le respiratoire"),
        PhraseEntry(phrase: "Atemnot", meaning: "La dyspnée"),
        PhraseEntry(phrase: "Bronchospasmus", meaning: "Le bronchospasme"),
        PhraseEntry(phrase: "Asthma", meaning: "L'asthme"),
        PhraseEntry(phrase: "Pneumo-Hämo-Chylo-Thorax", meaning: "Le pneumo-hémo-chylo-thorax"),
        PhraseEntry(phrase: "Akutes Lungenödem (OAP)", meaning: "L'œdème aigu du poumon (OAP)"),
        PhraseEntry(phrase: "Vergiftung", meaning: "L'intoxication"),
        PhraseEntry(phrase: "Chronisch obstruktive Lungenerkrankung (COPD)", meaning: "BPCO"),
        PhraseEntry(phrase: "Inhalation", meaning: "L'inhalation"),
        PhraseEntry(phrase: "Überdosierung von Medikamenten", meaning: "Le surdosage médicamenteux"),
        PhraseEntry(phrase: "Atemstillstand", meaning: "L'arrêt respiratoire"),
        PhraseEntry(phrase: "Das Herz-Kreislauf-System", meaning: "Le cardio-vasculaire"),
        PhraseEntry(phrase: "Rhythmusstörungen", meaning: "Les troubles du rythme"),
        PhraseEntry(phrase: "Vorhofarrhythmie", meaning: "L'arythmie auriculaire"),
        PhraseEntry(phrase: "Supraventrikuläre Extrasystole", meaning: "L'extra-systole supra-ventriculaire"),
        PhraseEntry(phrase: "Vorhoftachykardie", meaning: "La tachycardie atriale"),
        PhraseEntry(phrase: "Vorhofflattern", meaning: "La flutter auriculaire"),
        PhraseEntry(phrase: "Vorhofflimmern", meaning: "La fibrillation auriculaire"),
        PhraseEntry(phrase: "Bradykardie", meaning: "La bradycardie"),
        PhraseEntry(phrase: "Sinoatrialer Block (BSA)", meaning: "Le bloc sino-auriculaire (BSA)"),
        PhraseEntry(phrase: "Atrioventrikulärer Block (AVB)", meaning: "Le bloc auriculo-ventriculaire (BAV)"),
        PhraseEntry(phrase: "Ventrikuläre Extrasystole (VES)", meaning: "L'extra-systole ventriculaire (ESV)"),
        PhraseEntry(phrase: "Ventrikuläre Tachykardie (VT)", meaning: "La tachycardie ventriculaire (TV)"),
        PhraseEntry(phrase: "Kammerflattern", meaning: "La flutter ventriculaire"),
        PhraseEntry(phrase: "Kammerflimmern", meaning: "La fibrillation ventriculaire"),
        PhraseEntry(phrase: "Herzpumpversagen", meaning: "La défaillance de la pompe cardiaque"),
        PhraseEntry(phrase: "Herzinsuffizienz", meaning: "L'insuffisance cardiaque"),
        PhraseEntry(phrase: "Klappenversagen", meaning: "La défaillance valvulaire"),
        PhraseEntry(phrase: "Endokarditis", meaning: "L'endocardite"),
        PhraseEntry(phrase: "Myokardinfarkt", meaning: "L'infarctus du myocarde"),
        PhraseEntry(phrase: "Koronarstenose", meaning: "La sténose coronarienne"),
        PhraseEntry(phrase: "Ischämie", meaning: "L'ischémie"),
        PhraseEntry(phrase: "Trauma", meaning: "Le traumatisme"),
        PhraseEntry(phrase: "Blutung", meaning: "L'hémorragie"),
        PhraseEntry(phrase: "Schockzustände", meaning: "Les états de choc"),
        PhraseEntry(phrase: "Anaphylaktischer Schock", meaning: "Le choc anaphylactique"),
        PhraseEntry(phrase: "Septischer Schock", meaning: "Le choc septique"),
        PhraseEntry(phrase: "Kardiogener Schock", meaning: "Le choc cardiogénique"),
        PhraseEntry(phrase: "Hämorrhagischer Schock", meaning: "Le choc hémorragique"),
        PhraseEntry(phrase: "Neurogener Schock", meaning: "Le choc neurogénique"),
      ],
    );
  }
}
