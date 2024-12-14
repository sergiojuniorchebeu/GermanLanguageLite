import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'Lecon2.dart';
import 'lecon1.dart';

class LessonListPage2 extends StatefulWidget {
  const LessonListPage2({super.key});

  @override
  _LessonListPage2State createState() => _LessonListPage2State();
}

class _LessonListPage2State extends State<LessonListPage2> {
  final List<Map<String, dynamic>> _lessons = [
    {
      'title': "Les constantes",
      'description': "le formulaire d'admission fait référence aux documents nécessaires ou au processus d'inscription",
      'image': 'assets/img/medical-history.png',
      'onTapAction': () => const Lesson1C2Page(),
    },
    {
      'title': "L'évaluation de la douleur",
      'description': 'Apprenez à évaluer la douleur en Allemand.',
      'image': 'assets/img/muscle-pain.png',
      'onTapAction': () => const Lesson2C2Page(),
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
                    ? Colors.grey[800] // Fond de champ de recherche sombre
                    : Colors.white, // Fond de champ de recherche clair
                hintText: 'Rechercher une leçon',
                hintStyle: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white70 // Texte des indices en blanc pour le mode sombre
                      : Colors.grey, // Texte des indices en gris pour le mode clair
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

  // Carte des leçons
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
                            ? Colors.white70 // Texte de description en gris clair pour le mode sombre
                            : Colors.grey, // Texte de description en gris pour le mode clair
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
