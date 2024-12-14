import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'leçon1.dart';
import 'leçon2.dart';
import 'leçon3.dart';


class LessonList10Page extends StatefulWidget {
  const LessonList10Page({super.key});

  @override
  _LessonList10PageState createState() => _LessonList10PageState();
}

class _LessonList10PageState extends State<LessonList10Page> {
  final List<Map<String, dynamic>> _lessons = [
    {
      'title': "Les différents étiologies de situations d'urgence",
      'description': "Die verschiedenen Ätiologien von Notfallsituationen",
      'image': 'assets/img/emergency.png',
      'onTapAction': () => const Lesson1C10Page(),
    },
    {
      'title': "La conduite à tenir chez l'adulte",
      'description': "Das Verhalten bei Erwachsenen",
      'image': 'assets/img/doctor-consultation.png',
      'onTapAction': () => const Lesson2C10Page(),
    },
    {
      'title': "La prise en charge complémentaire",
      'description': "Die zusätzlichen Maßnahmen",
      'image': 'assets/img/medical-checkup.png',
      'onTapAction': () => const Lesson3C10Page(),
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
                    ? Colors.grey[800] // Fond du champ de recherche sombre
                    : Colors.white, // Fond du champ de recherche clair
                hintText: 'Rechercher une leçon',
                hintStyle: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white70 // Texte des indices en blanc dans le mode sombre
                      : Colors.grey, // Texte des indices en gris dans le mode clair
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white70 // Icône de recherche blanche dans le mode sombre
                      : Colors.grey, // Icône de recherche grise dans le mode clair
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

  // Construction de la carte des leçons
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
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[800] // Fond de carte sombre pour le mode sombre
          : Colors.white, // Fond de carte clair pour le mode clair
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
                            ? Colors.white // Texte du titre en blanc pour le mode sombre
                            : Colors.black, // Texte du titre en noir pour le mode clair
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white70 // Texte de la description en blanc clair pour le mode sombre
                            : Colors.grey, // Texte de la description en gris pour le mode clair
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
