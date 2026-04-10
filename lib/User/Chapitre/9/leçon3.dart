import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class Lesson3C9Page extends StatelessWidget {
  const Lesson3C9Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      chapterNumber: 9,
      accentColor: kPurple,
      accentLight: kPurpleLight,
      title: "Les voies d'administration des médicaments",
      content: "\"Les voies d'administration des médicaments\" signifie \"Die Verabreichungswege von Medikamenten\" en allemand.",
      examples: [
        PhraseEntry(phrase: "oral = durch den Mund", meaning: "orale = par la bouche"),
        PhraseEntry(phrase: "die Tabletten", meaning: "les comprimés (m.)"),
        PhraseEntry(phrase: "die Dragees", meaning: "les dragées (f.)"),
        PhraseEntry(phrase: "die Kapseln", meaning: "les gélules (f.)"),
        PhraseEntry(phrase: "die Tropfen", meaning: "les gouttes (f.)"),
        PhraseEntry(phrase: "der Sirup", meaning: "le sirop"),
        PhraseEntry(phrase: "sublingual = unter der Zunge zergehen lassen", meaning: "sublinguale = laisse fondre sous la langue"),
        PhraseEntry(phrase: "die Kautabletten", meaning: "les comprimés à croquer (m.)"),
        PhraseEntry(phrase: "die Lutschtabletten", meaning: "les comprimés à sucer (m.)"),
        PhraseEntry(phrase: "die Lyoc-Tabletten", meaning: "les comprimés Lyoc (m.)"),
        PhraseEntry(phrase: "rektal = rektal verabreichen", meaning: "rectale = administrer en intra rectal"),
        PhraseEntry(phrase: "das Zäpfchen", meaning: "le suppositoire"),
        PhraseEntry(phrase: "der Einlauf", meaning: "la lavement"),
        PhraseEntry(phrase: "intravenös = in die Vene spritzen", meaning: "intra veineuse = injecter dans la veine"),
        PhraseEntry(phrase: "die Infusionen", meaning: "les perfusions (f.)"),
        PhraseEntry(phrase: "die Injektionen", meaning: "les injections (f.)"),
        PhraseEntry(phrase: "intramuskulär = in den Muskel spritzen", meaning: "intra musculaire = injecter dans le muscle"),
        PhraseEntry(phrase: "kutan = auf die Haut auftragen", meaning: "cutanée = étaler sur la peau"),
        PhraseEntry(phrase: "die Creme", meaning: "la crème"),
        PhraseEntry(phrase: "die Salbe", meaning: "la pommade"),
        PhraseEntry(phrase: "das Gel", meaning: "le gel"),
        PhraseEntry(phrase: "die Paste", meaning: "la pâte"),
        PhraseEntry(phrase: "transdermal = auf die Haut kleben", meaning: "transdermique = coller sur la peau"),
        PhraseEntry(phrase: "ein Pflaster", meaning: "un patch"),
        PhraseEntry(phrase: "subkutan = unter die Haut spritzen", meaning: "sous-cutanée = injecter sous la peau"),
        PhraseEntry(phrase: "die subkutane Infusion", meaning: "la perfusion sous-cutanée"),
        PhraseEntry(phrase: "die subkutane Injektion", meaning: "l'injection sous-cutanée (f.)"),
        PhraseEntry(phrase: "vaginal = in die Scheide einführen", meaning: "vaginale = insérer dans le vagin"),
        PhraseEntry(phrase: "konjunktival = ins Auge träufeln", meaning: "conjonctivale = instiller dans l'œil (m.)"),
        PhraseEntry(phrase: "die Tropfen / ein Augentropfen", meaning: "des gouttes / un collyre"),
        PhraseEntry(phrase: "eine Augensalbe", meaning: "une pommade ophtalmique"),
        PhraseEntry(phrase: "nasal = in die Nase sprühen", meaning: "nasale = pulvériser dans le nez"),
        PhraseEntry(phrase: "das Nasenspray", meaning: "le spray nasal"),
        PhraseEntry(phrase: "die Nasentropfen", meaning: "les gouttes nasales (f.)"),
        PhraseEntry(phrase: "Inhalation = durch die Atemwege inhalieren", meaning: "inhalation = inhaler par les voies respiratoires"),
        PhraseEntry(phrase: "das Aerosol", meaning: "l'aérosol (m.)"),
      ],
    );
  }
}
