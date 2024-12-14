import 'package:flutter/material.dart';

class CourseListPage extends StatelessWidget {
  final List<Map<String, dynamic>> courses = [
    {
      'title': 'Introduction à Flutter',
      'description': 'Apprenez les bases de Flutter pour le développement mobile.',
      'imageUrl': 'assets/img/github.png',
      'progress': 0.4,
    },
    {
      'title': 'Widgets Flutter',
      'description': 'Découvrez les widgets essentiels pour construire votre UI.',
      'imageUrl': 'assets/img/widgets_flutter.png',
      'progress': 0.8,
    },
    {
      'title': 'Animations Flutter',
      'description': 'Ajoutez des animations élégantes à vos applications Flutter.',
      'imageUrl': 'assets/img/animations_flutter.png',
      'progress': 0.3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes Cours"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailPage(course: course),
                ),
              );
            },
            child: CourseCard(course: course),
          );
        },
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              course['imageUrl'],
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course['title'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  course['description'],
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: course['progress'],
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.blueAccent,
                  minHeight: 8,
                ),
                const SizedBox(height: 8),
                Text(
                  'Progression : ${(course['progress'] * 100).toInt()}%',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course['title']),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Text(
          'Détails du cours : ${course['title']}',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
