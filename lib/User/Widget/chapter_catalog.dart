import 'package:flutter/material.dart';
import 'package:projet2/User/Widget/Widget.dart';
import 'package:projet2/core/theme/colors.dart';

import '../Chapitre/1/liste lecon chapitre1.dart';
import '../Chapitre/10/Lesson List 10.dart';
import '../Chapitre/11/List Lesson 11.dart';
import '../Chapitre/2/List Lesson Chaiptre 2.dart';
import '../Chapitre/3/List Lesson 3.dart';
import '../Chapitre/4/Liste Lecons 4.dart';
import '../Chapitre/5/Liste des Lessons 5.dart';
import '../Chapitre/6/List cours 6.dart';
import '../Chapitre/7/Liste Lesson 7.dart';
import '../Chapitre/8/List Lesson Page 8.dart';
import '../Chapitre/9/Liste lesson 9.dart';

List<ChapterData> buildStudentChapters() {
  return const [
    ChapterData(
      number: 1,
      titleFR: "L'admission d'un patient",
      titleDE: 'Die Aufnahme eines Patienten',
      accentColor: kBlue,
      accentLight: kBlueLight,
      icon: Icons.assignment_ind_outlined,
      page: LessonListPage(),
    ),
    ChapterData(
      number: 2,
      titleFR: 'La mesure des parametres',
      titleDE: 'Die Messung der Parameter',
      accentColor: kGreen,
      accentLight: kGreenLight,
      icon: Icons.monitor_heart_outlined,
      page: LessonListPage2(),
    ),
    ChapterData(
      number: 3,
      titleFR: 'Manger - boire - eliminer',
      titleDE: 'Essen - trinken - ausscheiden',
      accentColor: kPurple,
      accentLight: kPurpleLight,
      icon: Icons.restaurant_outlined,
      page: LessonListPage3(),
    ),
    ChapterData(
      number: 4,
      titleFR: "Les soins d'hygiene",
      titleDE: 'Die Grundpflege',
      accentColor: kPeach,
      accentLight: kPeachLight,
      icon: Icons.clean_hands_outlined,
      page: LessonList4Page(),
    ),
    ChapterData(
      number: 5,
      titleFR: 'La physiopathologie',
      titleDE: 'Die Pathophysiologie',
      accentColor: kCoral,
      accentLight: kCoralLight,
      icon: Icons.biotech_outlined,
      page: LessonList5Page(),
    ),
    ChapterData(
      number: 6,
      titleFR: 'Les examens complementaires',
      titleDE: 'Die Untersuchungen',
      accentColor: kYellow,
      accentLight: kYellowLight,
      icon: Icons.science_outlined,
      page: LessonList6Page(),
    ),
    ChapterData(
      number: 7,
      titleFR: 'Labo - prelevement',
      titleDE: 'Labor - Entnahme',
      accentColor: kBlue,
      accentLight: kBlueLight,
      icon: Icons.colorize_outlined,
      page: LessonList7Page(),
    ),
    ChapterData(
      number: 8,
      titleFR: "L'anesthesie & l'operation",
      titleDE: 'Die Anasthesie & die Operation',
      accentColor: kGreen,
      accentLight: kGreenLight,
      icon: Icons.local_hospital_outlined,
      page: LessonList8Page(),
    ),
    ChapterData(
      number: 9,
      titleFR: 'Les soins therapeutiques',
      titleDE: 'Die Behandlungspflege',
      accentColor: kPurple,
      accentLight: kPurpleLight,
      icon: Icons.medication_outlined,
      page: LessonList9Page(),
    ),
    ChapterData(
      number: 10,
      titleFR: 'La conduite a tenir en urgence',
      titleDE: 'Das Verhalten im Notfall',
      accentColor: kCoral,
      accentLight: kCoralLight,
      icon: Icons.emergency_outlined,
      page: LessonList10Page(),
    ),
    ChapterData(
      number: 11,
      titleFR: 'La sortie & le transfert',
      titleDE: 'Die Entlassung & Verlegung',
      accentColor: kPeach,
      accentLight: kPeachLight,
      icon: Icons.transfer_within_a_station_outlined,
      page: LessonList11Page(),
    ),
    ChapterData(
      number: 12,
      titleFR: "L'anatomie",
      titleDE: 'Die Anatomie',
      accentColor: kInk500,
      accentLight: kInk100,
      icon: Icons.accessibility_new_outlined,
      isComingSoon: true,
    ),
    ChapterData(
      number: 13,
      titleFR: 'Les abreviations',
      titleDE: 'Die Abkurzungen',
      accentColor: kInk500,
      accentLight: kInk100,
      icon: Icons.abc_outlined,
      isComingSoon: true,
    ),
  ];
}
