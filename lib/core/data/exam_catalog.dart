import 'package:flutter/material.dart';
import 'package:projet2/core/theme/colors.dart';
import 'package:projet2/shared/widgets/lesson_template.dart';

class ChapterExamData {
  final int chapterNumber;
  final String titleFR;
  final String titleDE;
  final Color accentColor;
  final Color accentLight;
  final List<PhraseEntry> phrases;

  const ChapterExamData({
    required this.chapterNumber,
    required this.titleFR,
    required this.titleDE,
    required this.accentColor,
    required this.accentLight,
    required this.phrases,
  });
}

const List<ChapterExamData> chapterExamCatalog = [
  ChapterExamData(
    chapterNumber: 1,
    titleFR: "L'admission d'un patient",
    titleDE: "Die Aufnahme eines Patienten",
    accentColor: kBlue,
    accentLight: kBlueLight,
    phrases: [
      PhraseEntry(phrase: 'Guten Tag, Frau', meaning: 'Bonjour Madame'),
      PhraseEntry(
          phrase: 'Ich bin Krankenschwester', meaning: 'Je suis infirmière'),
      PhraseEntry(
          phrase: 'Füllen Sie bitte das Anmeldeformular aus.',
          meaning: "Veuillez remplir le formulaire d'admission."),
      PhraseEntry(
          phrase: 'Haben Sie die Krankenversicherungskarte?',
          meaning: 'Avez-vous la carte vitale ?'),
      PhraseEntry(
          phrase: 'Ich werde Ihnen den Tagesablauf erklären.',
          meaning: 'Je vais vous expliquer le déroulement de la journée.'),
      PhraseEntry(
          phrase: 'Falls Sie etwas brauchen, hier ist die Klingel.',
          meaning: 'Si vous avez besoin de quelque chose, voici la sonnerie.'),
      PhraseEntry(
          phrase: 'Kann ich jemanden benachrichtigen?',
          meaning: "Est-ce que je peux prévenir quelqu'un ?"),
      PhraseEntry(
          phrase: 'Wissen Sie, wo Sie sind?',
          meaning: 'Savez-vous où vous êtes ?'),
      PhraseEntry(
          phrase: 'Haben Sie Atembeschwerden?',
          meaning: 'Avez-vous des difficultés à respirer ?'),
      PhraseEntry(phrase: 'Das Sturzrisiko', meaning: 'Le risque de chute'),
    ],
  ),
  ChapterExamData(
    chapterNumber: 2,
    titleFR: 'La mesure des paramètres',
    titleDE: 'Die Messung der Parameter',
    accentColor: kGreen,
    accentLight: kGreenLight,
    phrases: [
      PhraseEntry(
          phrase: 'Ich messe jetzt Ihre Temperatur.',
          meaning: 'Je vais prendre votre température.'),
      PhraseEntry(
          phrase: 'Sie haben Fieber.', meaning: 'Vous avez de la fièvre.'),
      PhraseEntry(
          phrase: 'Ich messe jetzt Ihren Blutdruck.',
          meaning: 'Je vais mesurer votre tension artérielle.'),
      PhraseEntry(
          phrase: 'Ihr Blutdruck liegt bei 130/80 (130 zu 80).',
          meaning: 'Votre tension est de 13/8 cm Hg (13 sur 8).'),
      PhraseEntry(
          phrase: 'Ich messe jetzt Ihre Sauerstoffsättigung.',
          meaning: 'Je vais mesurer votre saturation en oxygène.'),
      PhraseEntry(phrase: 'Haben Sie Schmerzen?', meaning: 'Avez-vous mal ?'),
      PhraseEntry(
          phrase: 'Wo haben Sie Schmerzen?',
          meaning: 'Où avez-vous des douleurs ?'),
      PhraseEntry(
          phrase: 'Es ist ein stechender Schmerz.',
          meaning: "C'est une douleur piquante."),
      PhraseEntry(
          phrase: 'Ich gebe Ihnen ein Schmerzmittel.',
          meaning: 'Je vais vous donner un antalgique.'),
      PhraseEntry(
          phrase: 'Ich rufe den Arzt.',
          meaning: 'Je vais prévenir le médecin.'),
    ],
  ),
  ChapterExamData(
    chapterNumber: 3,
    titleFR: 'Manger – boire – éliminer',
    titleDE: 'Essen – trinken – ausscheiden',
    accentColor: kPurple,
    accentLight: kPurpleLight,
    phrases: [
      PhraseEntry(phrase: 'Eine Normalkost', meaning: 'Un régime normal'),
      PhraseEntry(phrase: 'Eine Diabetesdiät', meaning: 'Un régime diabétique'),
      PhraseEntry(
          phrase: 'Haben Sie eine spezielle Diät?',
          meaning: 'Avez-vous un régime alimentaire spécifique ?'),
      PhraseEntry(
          phrase: 'Haben Sie Übelkeit?', meaning: 'Avez-vous des nausées ?'),
      PhraseEntry(
          phrase: 'Haben Sie Durchfall?',
          meaning: 'Avez-vous de la diarrhée ?'),
      PhraseEntry(phrase: 'Enterale Ernährung', meaning: 'Nutrition entérale'),
      PhraseEntry(
          phrase: 'Parenterale Ernährung', meaning: 'Nutrition parentérale'),
      PhraseEntry(
          phrase: 'Wann war Ihr letzter Stuhlgang?',
          meaning: 'De quand date votre dernière selle ?'),
      PhraseEntry(
          phrase: 'Haben Sie Blut im Stuhl?',
          meaning: 'Avez-vous du sang dans les selles ?'),
      PhraseEntry(
          phrase: 'Ist Ihnen übel?', meaning: 'Avez-vous envie de vomir ?'),
    ],
  ),
  ChapterExamData(
    chapterNumber: 4,
    titleFR: "Les soins d'hygiène",
    titleDE: 'Die Grundpflege',
    accentColor: kPeach,
    accentLight: kPeachLight,
    phrases: [
      PhraseEntry(
          phrase: 'Die vollständige Körperpflege',
          meaning: 'La toilette complète'),
      PhraseEntry(
          phrase: 'Brauchen Sie Hilfe bei der Körperpflege?',
          meaning: "Avez-vous besoin d'aide pour la toilette ?"),
      PhraseEntry(
          phrase: 'Soll ich Sie zur Toilette begleiten?',
          meaning: 'Dois-je vous accompagner aux toilettes ?'),
      PhraseEntry(phrase: 'Die Waschschüssel', meaning: 'La bassine'),
      PhraseEntry(phrase: 'Der Waschlappen', meaning: 'Le gant de toilette'),
      PhraseEntry(
          phrase: 'Brauchen Sie Hilfe beim Aufstehen?',
          meaning: "Avez-vous besoin d'aide pour vous lever ?"),
      PhraseEntry(
          phrase: 'Können Sie den Arm hochheben?',
          meaning: 'Pouvez-vous lever le bras ?'),
      PhraseEntry(
          phrase: 'Ich werde das Kopfteil hochstellen.',
          meaning: 'Je vais vous remonter la tête du lit.'),
      PhraseEntry(
          phrase: 'Ich werde die Seitenteile / das Bettgitter hoch machen.',
          meaning: 'Je vais remonter les barrières du lit.'),
    ],
  ),
  ChapterExamData(
    chapterNumber: 5,
    titleFR: 'La physiopathologie',
    titleDE: 'Die Pathophysiologie',
    accentColor: kCoral,
    accentLight: kCoralLight,
    phrases: [
      PhraseEntry(phrase: 'Eine Blässe', meaning: 'Une pâleur'),
      PhraseEntry(phrase: 'Eine Zyanose', meaning: 'Une cyanose'),
      PhraseEntry(phrase: 'Eine Blutung', meaning: 'Un saignement'),
      PhraseEntry(
          phrase: 'Dyspnoe (f.) / Atemnot (f.)',
          meaning: 'Une dyspnée / une détresse respiratoire'),
      PhraseEntry(phrase: 'Eine Verwirrtheit', meaning: 'Une confusion'),
      PhraseEntry(
          phrase: 'Ein Bewusstseinsverlust / eine Ohnmacht',
          meaning: 'Une perte de connaissance / une inconscience'),
      PhraseEntry(
          phrase: 'Der Patient klagt über...',
          meaning: 'Le patient se plaint de...'),
      PhraseEntry(phrase: 'Palpitationen (f.)', meaning: 'Palpitations (f.)'),
      PhraseEntry(phrase: 'Schwindel (m.)', meaning: 'Vertige (m.)'),
      PhraseEntry(phrase: 'Kopfschmerzen (f.)', meaning: 'Céphalées (f.)'),
    ],
  ),
  ChapterExamData(
    chapterNumber: 6,
    titleFR: 'Les examens complémentaires',
    titleDE: 'Die Untersuchungen',
    accentColor: kYellow,
    accentLight: kYellowLight,
    phrases: [
      PhraseEntry(
          phrase: 'Ich werde Sie für diese Untersuchung vorbereiten',
          meaning: 'Je vais vous préparer pour cet examen'),
      PhraseEntry(
          phrase: 'Eine CT-Untersuchung mit/ohne Kontrastmittelinjektion',
          meaning:
              'Un scanner (TDM) avec/sans injection de produit de contraste iodé'),
      PhraseEntry(
          phrase: 'Ein MRT (Magnetresonanztomographie)',
          meaning: 'Une IRM (imagerie par résonance magnétique)'),
      PhraseEntry(
          phrase: 'Ein Ruhe-EKG / ein Belastungs-EKG / ein Holter-EKG',
          meaning: "Un ECG au repos / un ECG d'effort / un Holter ECG"),
      PhraseEntry(
          phrase: 'Ich werde Ihre Leistengegend rasieren.',
          meaning: "Je vais vous raser le pli de l'aine."),
      PhraseEntry(
          phrase: 'Sie müssen ruhig liegen bleiben.',
          meaning: 'Il faut rester allongé sans bouger.'),
      PhraseEntry(
          phrase: 'Ich werde Ihnen ein Spray unter die Zunge geben/sprühen.',
          meaning: 'Je vais vous donner / pulvériser un spray sous la langue.'),
      PhraseEntry(
          phrase: 'Sie müssen 4 bis 6 Stunden strikte Bettruhe einhalten.',
          meaning:
              'Il faudra garder un repos strict au lit pendant 4 à 6 heures.'),
    ],
  ),
  ChapterExamData(
    chapterNumber: 7,
    titleFR: 'Labo – prélèvement',
    titleDE: 'Labor – Entnahme',
    accentColor: kBlue,
    accentLight: kBlueLight,
    phrases: [
      PhraseEntry(
          phrase: 'Ich werde Ihnen Blut abnehmen.',
          meaning: 'Je vais vous faire une prise de sang.'),
      PhraseEntry(phrase: 'Der Stauschlauch', meaning: 'Le garrot'),
      PhraseEntry(phrase: 'Ein Antiseptikum', meaning: 'Un antiseptique'),
      PhraseEntry(
          phrase: 'Es wird ein wenig stechen.',
          meaning: 'Ça va piquer un peu.'),
      PhraseEntry(
          phrase: 'Ich werde Ihren Blutzucker messen.',
          meaning: 'Je vais vous mesurer le taux de sucre.'),
      PhraseEntry(
          phrase: 'Das Blutzuckermessgerät / der Glukometer',
          meaning: 'Le lecteur de glycémie / le glucomètre'),
      PhraseEntry(phrase: 'Die Leukozyten', meaning: 'Les leucocytes (m.)'),
      PhraseEntry(phrase: 'Das Hämoglobin', meaning: "L'hémoglobine (f.)"),
      PhraseEntry(phrase: 'Das Kalium', meaning: 'Le potassium'),
      PhraseEntry(phrase: 'INR', meaning: 'INR'),
    ],
  ),
  ChapterExamData(
    chapterNumber: 8,
    titleFR: "L'anesthésie & l'opération",
    titleDE: 'Die Anästhesie & die Operation',
    accentColor: kGreen,
    accentLight: kGreenLight,
    phrases: [
      PhraseEntry(
          phrase: 'Eine lokale Anästhesie',
          meaning: 'Une anesthésie locale (AL)'),
      PhraseEntry(
          phrase: 'Eine Periduralanästhesie',
          meaning: 'Une anesthésie péridurale'),
      PhraseEntry(
          phrase: 'Ich werde Sie für die Operation vorbereiten.',
          meaning: "Je vais vous préparer pour l'opération."),
      PhraseEntry(
          phrase: 'Sie müssen nüchtern bleiben.',
          meaning: 'Il faudra être à jeun.'),
      PhraseEntry(
          phrase: 'Ich werde Ihre Vitalwerte überprüfen.',
          meaning: 'Je vais vérifier vos constantes vitales.'),
      PhraseEntry(
          phrase: 'Ich werde Ihren Verband kontrollieren.',
          meaning: 'Je vais contrôler votre pansement.'),
      PhraseEntry(
          phrase: 'Ich werde Ihnen helfen, sich allmählich zu mobilisieren.',
          meaning: 'Je vais vous aider à vous mobiliser progressivement.'),
      PhraseEntry(
          phrase: 'Ich werde Ihren Verband erneuern.',
          meaning: 'Je vais vous refaire le pansement.'),
      PhraseEntry(
          phrase: 'Ich werde die Wunde untersuchen.',
          meaning: 'Je vais observer la plaie.'),
      PhraseEntry(phrase: 'eitrig', meaning: 'purulentes'),
    ],
  ),
  ChapterExamData(
    chapterNumber: 9,
    titleFR: 'Les soins thérapeutiques',
    titleDE: 'Die Behandlungspflege',
    accentColor: kPurple,
    accentLight: kPurpleLight,
    phrases: [
      PhraseEntry(
          phrase: 'Ich werde Ihnen einen Venenkatheter legen.',
          meaning: 'Je vais vous poser un cathéter veineux.'),
      PhraseEntry(
          phrase: 'Ich werde die Infusionsleitung entlüften.',
          meaning: 'Je vais purger la tubulure.'),
      PhraseEntry(phrase: 'Ein Dreiwegehahn', meaning: 'Un robinet 3 voies'),
      PhraseEntry(
          phrase: 'Ich werde Ihnen einen Blasenkatheter legen.',
          meaning: 'Je vais vous poser une sonde urinaire.'),
      PhraseEntry(
          phrase: 'die sterilen Handschuhe', meaning: 'les gants stériles'),
      PhraseEntry(
          phrase: 'oral = durch den Mund', meaning: 'orale = par la bouche'),
      PhraseEntry(
          phrase: 'intravenös = in die Vene spritzen',
          meaning: 'intra veineuse = injecter dans la veine'),
      PhraseEntry(phrase: 'das Aerosol', meaning: "l'aérosol (m.)"),
      PhraseEntry(
          phrase: 'die Nebenwirkungen',
          meaning: 'Les effets indésirables (m.)'),
      PhraseEntry(phrase: 'Morgens nüchtern', meaning: 'Le matin à jeun'),
    ],
  ),
  ChapterExamData(
    chapterNumber: 10,
    titleFR: "La conduite à tenir en urgence",
    titleDE: 'Das Verhalten im Notfall',
    accentColor: kCoral,
    accentLight: kCoralLight,
    phrases: [
      PhraseEntry(phrase: 'Atemnot', meaning: 'La dyspnée'),
      PhraseEntry(
          phrase: 'Akutes Lungenödem (OAP)',
          meaning: "L'œdème aigu du poumon (OAP)"),
      PhraseEntry(phrase: 'Myokardinfarkt', meaning: "L'infarctus du myocarde"),
      PhraseEntry(
          phrase: 'Anaphylaktischer Schock', meaning: 'Le choc anaphylactique'),
      PhraseEntry(
          phrase: 'Stabile Seitenlage',
          meaning: 'Position latérale de sécurité (PLS)'),
      PhraseEntry(
          phrase: 'Herz-Lungen-Wiederbelebung',
          meaning: 'Réanimation cardio-pulmonaire'),
      PhraseEntry(
          phrase:
              'Ich werde die Atemfrequenz und die Sauerstoffsättigung messen.',
          meaning:
              'Je vais mesurer la fréquence respiratoire et la saturation en oxygène.'),
      PhraseEntry(
          phrase: 'Einer Sauerstoffmaske', meaning: 'Un masque à oxygène'),
      PhraseEntry(
          phrase: 'Dem Beatmungsbeutel (BAVU)',
          meaning: 'Un ballon de ventilation (BAVU)'),
      PhraseEntry(
          phrase: 'Endotracheale Absaugung.',
          meaning: 'Aspiration endo-trachéale.'),
    ],
  ),
  ChapterExamData(
    chapterNumber: 11,
    titleFR: 'La sortie & le transfert',
    titleDE: 'Die Entlassung & Verlegung',
    accentColor: kPeach,
    accentLight: kPeachLight,
    phrases: [
      PhraseEntry(
          phrase:
              'Für die externe Verlegung wird die Pflegeüberleitung ausgefüllt.',
          meaning:
              'Pour le transfert externe, il faut compléter une fiche de liaison.'),
      PhraseEntry(
          phrase: 'Sie werden heute entlassen:',
          meaning: "Vous pouvez sortir aujourd'hui :"),
      PhraseEntry(phrase: 'nach Hause', meaning: 'à domicile (m.)'),
      PhraseEntry(
          phrase: 'in die Rehabilitation (ugs.: Reha)',
          meaning: 'en SSR / en rééducation (f.)'),
      PhraseEntry(
          phrase: 'Hier sind Ihre Entlassungspapiere.',
          meaning: 'Voici vos papiers de sortie.'),
      PhraseEntry(
          phrase: 'Sie müssen zu Ihrem Hausarzt gehen.',
          meaning: 'Il faudra aller chez votre médecin traitant.'),
      PhraseEntry(
          phrase: 'Ich werde Sie über das Verhalten informieren.',
          meaning: 'Je vais vous informer sur la conduite à tenir.'),
      PhraseEntry(
          phrase: 'Ich werde die Informationen in der Patientenakte vermerken.',
          meaning:
              'Je vais tracer les informations dans le dossier du patient.'),
      PhraseEntry(
          phrase: 'Muss ich für Sie einen Krankenwagen rufen?',
          meaning: 'Est-ce que je dois vous commander une ambulance ?'),
    ],
  ),
];

ChapterExamData getChapterExamData(int chapterNumber) {
  return chapterExamCatalog.firstWhere(
    (chapter) => chapter.chapterNumber == chapterNumber,
  );
}

List<PhraseEntry> buildFinalExamPool() {
  return chapterExamCatalog
      .expand((chapter) => chapter.phrases.take(4))
      .toList(growable: false);
}
