import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson1C6Page extends StatelessWidget {
  const Lesson1C6Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 6,
      accentColor: kYellow,
      accentLight: kYellowLight,
      title: "Les examens généraux",
      content: "\"Les examens généraux\" signifie \"Die allgemeinen Untersuchungen\" en allemand.",
      examples: [
        PhraseEntry(phrase: "Ich werde Sie für diese Untersuchung vorbereiten", meaning: "Je vais vous préparer pour cet examen"),
        PhraseEntry(phrase: "Vor der Untersuchung müssen Sie das Einwilligungsformular unterschreiben", meaning: "Avant l'examen vous devez signer la feuille de consentement"),
        PhraseEntry(phrase: "Sie werden ... haben", meaning: "Vous allez avoir..."),
        PhraseEntry(phrase: "Eine CT-Untersuchung mit/ohne Kontrastmittelinjektion", meaning: "Un scanner (TDM) avec/sans injection de produit de contraste iodé"),
        PhraseEntry(phrase: "Eine Herz-CT", meaning: "Un scanner cardiaque"),
        PhraseEntry(phrase: "Ein MRT (Magnetresonanztomographie)", meaning: "Une IRM (imagerie par résonance magnétique)"),
        PhraseEntry(phrase: "Eine Röntgenaufnahme / eine Thoraxaufnahme", meaning: "Une radiographie/ une radio-thoracique"),
        PhraseEntry(phrase: "Eine Szintigraphie", meaning: "Une scintigraphie"),
        PhraseEntry(phrase: "Eine Endoskopie / eine Gastroskopie / eine Koloskopie / eine bronchoskopische Fibroskopie", meaning: "Une endoscopie / une gastroscopie / une coloscopie / une fibroscopie bronchique"),
        PhraseEntry(phrase: "Ein Ruhe-EKG / ein Belastungs-EKG / ein Holter-EKG", meaning: "Un ECG au repos / un ECG d'effort / un Holter ECG"),
        PhraseEntry(phrase: "Eine transösophageale Echokardiographie", meaning: "Une échographie transœsophagienne"),
      ],
    );
  }
}
