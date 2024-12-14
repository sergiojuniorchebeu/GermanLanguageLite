import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'Cours.dart';


class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  final List<Map<String, String>> _lessons = [
    {
      'title': 'Introduction à Flutter',
      'description': 'Apprenez les bases de Flutter et créez votre première application.',
      'image': 'assets/img/github.png',
    },
    {
      'title': 'Widgets de base',
      'description': 'Découvrez les widgets de base tels que Container, Column, et Row.',
      'image': 'assets/img/facebook.png',
    },
    {
      'title': 'Gestion d\'état',
      'description': 'Comprenez les différentes approches pour gérer l\'état dans Flutter.',
      'image': 'assets/img/logo.png',
    },
    {
      'title': 'Navigation et routes',
      'description': 'Apprenez à naviguer entre différentes pages dans une application Flutter.',
      'image': 'assets/img/illustration-1.png',
    },
    {
      'title': 'Consommer une API',
      'description': 'Apprenez à récupérer des données à partir d\'une API et les afficher dans Flutter.',
      'image': 'assets/img/illustration-2.png',
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
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.3),
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.bars,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer(); // Simule un drawer
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
            'Leçons de formation',
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
            // Barre de recherche
            TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Rechercher une leçon',
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24), // Espacement

            // Liste animée des leçons
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
                            onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context)=> CoursePage())),
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
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16), // Espacement

              // Texte
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8), // Espacement
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

              // Icône de navigation
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
