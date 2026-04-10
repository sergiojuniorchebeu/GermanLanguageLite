import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson2C1Page extends StatelessWidget {
  const Lesson2C1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 1,
      accentColor: kBlue,
      accentLight: kBlueLight,
      title: "Les papiers d'admission / le formulaire d'admission",
      content: "\"Les papiers d'admission / le formulaire d'admission fait référence aux documents nécessaires ou au processus d'inscription, traduits en allemand.\" signifie \"Die Bewerbungsunterlagen / das Anmeldeformular bezieht sich auf die erforderlichen Dokumente oder den Anmeldeprozess, der ins Deutsche übersetzt wurde.\"",
      examples: [
        PhraseEntry(phrase: "Haben Sie Ihre Bewerbungsunterlagen?", meaning: "Avez-vous vos papiers d'admission ?"),
        PhraseEntry(phrase: "Füllen Sie bitte das Anmeldeformular aus.", meaning: "Veuillez remplir le formulaire d'admission."),
        PhraseEntry(phrase: "Brauchen Sie Unterstützung bei der Anmeldung?", meaning: "Avez-vous besoin d'aide pour l'inscription ?"),
        PhraseEntry(phrase: "Haben Sie die folgenden Unterlagen mitgebracht?", meaning: "Avez-vous rapporté les papiers suivants ?"),
        PhraseEntry(phrase: "Haben Sie das Verbindungsformular?", meaning: "Avez-vous la fiche de liaison ?"),
        PhraseEntry(phrase: "Haben Sie das Wunddokumentationsformular?", meaning: "Avez-vous la fiche de suivi des plaies ?"),
        PhraseEntry(phrase: "Haben Sie das Arztbrief?", meaning: "Avez-vous la lettre du médecin ?"),
        PhraseEntry(phrase: "Haben Sie die medizinische Zusammenfassung?", meaning: "Avez-vous le résumé médical ?"),
        PhraseEntry(phrase: "Haben Sie die Vorausverfügungen?", meaning: "Avez-vous les directives anticipées ?"),
        PhraseEntry(phrase: "Haben Sie die Krankenversicherungskarte?", meaning: "Avez-vous la carte vitale ?"),
        PhraseEntry(phrase: "Haben Sie das Pacemaker-Dokumentationsheft?", meaning: "Avez-vous le carnet de suivi du pacemaker ?"),
        PhraseEntry(phrase: "Haben Sie das AVK-Dokumentationsheft?", meaning: "Avez-vous le carnet de suivi des AVK ?"),
      ],
    );
  }
}
