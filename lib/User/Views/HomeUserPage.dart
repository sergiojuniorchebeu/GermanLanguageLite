import 'package:flutter/material.dart';
import 'package:projet2/User/Chapitre/1/liste%20lecon%20chapitre1.dart';
import 'package:projet2/User/Chapitre/6/List%20cours%206.dart';

import '../Chapitre/10/Lesson List 10.dart';
import '../Chapitre/11/List Lesson 11.dart';
import '../Chapitre/2/List Lesson Chaiptre 2.dart';
import '../Chapitre/3/List Lesson 3.dart';
import '../Chapitre/4/Liste Lecons 4.dart';
import '../Chapitre/5/Liste des Lessons 5.dart';
import '../Chapitre/7/Liste Lesson 7.dart';
import '../Chapitre/8/List Lesson Page 8.dart';
import '../Chapitre/9/Liste lesson 9.dart';
import '../Widget/AppBar.dart';
import '../Widget/Drawer.dart';
import '../Widget/Widget.dart';

class HomeUserPage extends StatefulWidget {
  const HomeUserPage({super.key});

  @override
  _HomeUserPageState createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF005D80),
      appBar: const CustomAppbar(title: "Hallo !"),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LanguageButton(flag: '🇫🇷', label: 'FR'),
                LanguageButton(flag: '🇩🇪', label: 'ALL'),
              ],
            ),
            const SizedBox(height: 16),
            /* Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: 'Recherche',
                      hintStyle: const TextStyle(color: Colors.white),
                      suffixIcon: const Icon(Icons.search, color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                        const BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                        const BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                )
              ],
            ),*/

            Text(
              'German Language 🙂',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                children: [
                  TaskCard(
                    title: "L’admission d’un patient",
                    subtitle: "Die Aufnahme eines Patienten",
                    onCardTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LessonListPage())),
                  ),
                  TaskCard(
                    title: "La mesure des paramètres",
                    subtitle: "Die Messung der Parameter",
                    onCardTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LessonListPage2())),
                  ),
                  TaskCard(
                    title: "Manger – boire – éliminer",
                    subtitle: "Essen – trinken – ausscheiden",
                    onCardTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LessonListPage3())),
                  ),
                  TaskCard(
                    title: "Les soins d’hygiène",
                    subtitle: "Die Grundpflege",
                    onCardTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LessonList4Page())),
                  ),
                  TaskCard(
                    title: "La physiopathologie",
                    subtitle: "Die Pathophysiologie",
                    onCardTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LessonList5Page())),
                  ),
                  TaskCard(
                    title: "Les examens complémentaires",
                    subtitle: "Die Untersuchungen",
                    onCardTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LessonList6Page())),
                  ),
                  TaskCard(
                    title: "Labo-prélèvement",
                    subtitle: "Labor – Entnahme",
                    onCardTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LessonList7Page())),
                  ),
                  TaskCard(
                    title: "L’anesthésie & l’opération",
                    subtitle: "Die Anästhesie & die Operation",
                    onCardTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LessonList8Page())),
                  ),
                  TaskCard(
                    title: "Les soins thérapeutiques",
                    subtitle: "Die Behandlungspflege",
                    onCardTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LessonList9Page())),
                  ),
                  TaskCard(
                    title: "La conduite à tenir en situation d’urgence",
                    subtitle: "Das Verhalten im Notfall",
                    onCardTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LessonList10Page())),
                  ),
                  TaskCard(
                    title: "La sortie & le transfert",
                    subtitle: "Die Entlassung & Verlegung",
                    onCardTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LessonList11Page())),
                  ),
                  TaskCard(
                    title: "L’anatomie",
                    subtitle: "Die Anatomie",
                    onCardTap: null,
                  ),
                  TaskCard(
                    title: "Les abréviations",
                    subtitle: "Die Abkürzungen",
                    onCardTap: null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
