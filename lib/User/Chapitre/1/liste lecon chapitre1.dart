import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:projet2/User/Chapitre/1/lecon2.dart';
import 'package:projet2/User/Chapitre/1/lecon3.dart';
import 'package:projet2/User/Chapitre/1/lecon4.dart';
import 'package:projet2/User/Chapitre/1/lecon5.dart';

import 'lecon1.dart';

class LessonListPage extends StatefulWidget {
  const LessonListPage({super.key});

  @override
  _LessonListPageState createState() => _LessonListPageState();
}

class _LessonListPageState extends State<LessonListPage> {
  final List<Map<String, dynamic>> _lessons = [
    {
      'title': 'Se présenter : sich vorstellen',
      'description': 'Apprenez les bases Pour se Presenter.',
      'image': 'assets/img/conversation.png',
      'onTapAction': () => const Lesson1C1Page(),
    },
    {
      'title': "Les papiers d'admission le formulaire d\'admission",
      'description': "le formulaire d'admission fait référence aux documents nécessaires ou au processus d'inscription",
      'image': 'assets/img/healthcare.png',
      'onTapAction': () => const Lesson2C1Page(),
    },
    {
      'title': "L'entretien d'orientation : das Orientierungsgespräch",
      'description': "Comprenez les différentes approches d'orientations",
      'image': 'assets/img/work-orientation.png',
      'onTapAction': () =>const Lesson3C1Page(),
    },
    {
      'title': "L'entretien d'accueil",
      'description': 'das Aufnahmegespräch',
      'image': 'assets/img/acceuil.png',
      'onTapAction': () => const Lesson4C1Page(),
    },
    {
      'title': '"Le recueil de données"',
      'description': "Die Datenerhebung",
      'image': 'assets/img/user.png',
      'onTapAction': () => const Lesson5C1Page(),
    },
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredLessons = _lessons
        .where((lesson) =>
        lesson['title']!.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF005D80),
      appBar: AppBar(
        backgroundColor: const Color(0xFF005D80),
        elevation: 0,
        shadowColor: Colors.black.withOpacity(0.3),
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Container(
          width: 300,
          height: 40,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00B46F), Color(0xFF005D80)],
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          child: const Text(
            'Leçons',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 15,),
            // Champ de recherche
            TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[800] // Couleur de fond sombre pour le mode sombre
                    : Colors.white, // Couleur de fond claire pour le mode clair
                hintText: 'Rechercher une leçon',
                hintStyle: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white70 // Texte de suggestion en blanc pour le mode sombre
                      : Colors.grey, // Texte de suggestion en gris pour le mode clair
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white70 // Icône de recherche en blanc pour le mode sombre
                      : Colors.grey, // Icône de recherche en gris pour le mode clair
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Liste des leçons
            Expanded(
              child: AnimationLimiter(
                child: ListView.builder(
                  itemCount: filteredLessons.length,
                  itemBuilder: (context, index) {
                    final lesson = filteredLessons[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        verticalOffset: 50,
                        child: FadeInAnimation(
                          child: _buildLessonCard(
                            title: lesson['title']!,
                            description: lesson['description']!,
                            image: lesson['image']!,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => lesson['onTapAction'](),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  Widget _buildLessonCard({
    required String title,
    required String description,
    required String image,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.3),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Icon(Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
