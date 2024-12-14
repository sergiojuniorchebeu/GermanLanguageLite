import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CourseDetailPage extends StatefulWidget {
  const CourseDetailPage({super.key});

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  final List<Map<String, dynamic>> _courseParts = [
    {
      'title': 'Introduction à Flutter',
      'description': 'Découvrez les bases de Flutter.',
      'videoUrl': 'https://flutter.dev/assets/videos/intro-video.mp4',
      'audioUrl': 'assets/audio/intro.mp3',
      'imageUrl': 'assets/img/github.png',
      'quizCompleted': false,
    },
    {
      'title': 'Widgets de base',
      'description': 'Apprenez à utiliser les widgets essentiels.',
      'videoUrl': null, // Pas de vidéo disponible
      'audioUrl': 'assets/audio/widgets.mp3',
      'imageUrl': 'assets/img/facebook.png',
      'quizCompleted': false,
    },
    {
      'title': 'Navigation et routes',
      'description': 'Naviguez entre différentes pages Flutter.',
      'videoUrl': 'https://flutter.dev/assets/videos/navigation.mp4',
      'audioUrl': null, // Pas d'audio disponible
      'imageUrl': null, // Pas d'image disponible
      'quizCompleted': false,
    },
  ];

  double _getProgress() {
    int completedQuizzes =
        _courseParts.where((part) => part['quizCompleted'] == true).length;
    return completedQuizzes / _courseParts.length;
  }

  void _completeQuiz(int index) {
    setState(() {
      _courseParts[index]['quizCompleted'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF005D80),
      appBar: AppBar(
        backgroundColor: const Color(0xFF005D80),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.bars,
            color: Colors.white,
            size: 40,
          ),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              alignment: Alignment.center,
              child: const Text(
                "Hallo !",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18, // Taille du texte
                ),
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Progression globale
            LinearPercentIndicator(
              lineHeight: 20.0,
              percent: _getProgress(),
              backgroundColor: Colors.grey.shade300,
              progressColor: const Color(0xFF00B46F),
              center: Text(
                '${(_getProgress() * 100).toInt()}%',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              barRadius: const Radius.circular(10),
            ),
            const SizedBox(height: 16),

            // Liste des parties
            Expanded(
              child: AnimationLimiter(
                child: ListView.builder(
                  itemCount: _courseParts.length,
                  itemBuilder: (context, index) {
                    final part = _courseParts[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        verticalOffset: 50,
                        child: FadeInAnimation(
                          child: _buildCoursePart(
                            title: part['title'],
                            description: part['description'],
                            imageUrl: part['imageUrl'],
                            videoUrl: part['videoUrl'],
                            audioUrl: part['audioUrl'],
                            isCompleted: part['quizCompleted'],
                            onQuizComplete: () => _completeQuiz(index),
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

  Widget _buildCoursePart({
    required String title,
    required String description,
    String? imageUrl,
    String? videoUrl,
    String? audioUrl,
    required bool isCompleted,
    required VoidCallback onQuizComplete,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre de la partie
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF005D80),
              ),
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Contenu multimédia
            Row(
              children: [
                // Image illustrative ou placeholder
                imageUrl != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                )
                    : Column(
                  children: const [
                    Icon(Icons.broken_image, color: Colors.grey, size: 50),
                    SizedBox(height: 4),
                    Text('Aucune image'),
                  ],
                ),
                const SizedBox(width: 16),

                // Vidéo et audio
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    videoUrl != null
                        ? IconButton(
                      icon: const Icon(Icons.play_circle, color: Color(0xFF00B46F)),
                      onPressed: () {
                        // Logique pour lire la vidéo
                        print('Lire la vidéo : $videoUrl');
                      },
                    )
                        : Column(
                      children: const [
                        Icon(Icons.video_library, color: Colors.grey),
                        SizedBox(height: 4),
                        Text('Pas de vidéo'),
                      ],
                    ),
                    audioUrl != null
                        ? IconButton(
                      icon: const Icon(Icons.audiotrack, color: Color(0xFF00B46F)),
                      onPressed: () {
                        // Logique pour lire l'audio
                        print('Lire l\'audio : $audioUrl');
                      },
                    )
                        : Column(
                      children: const [
                        Icon(Icons.music_note, color: Colors.grey),
                        SizedBox(height: 4),
                        Text('Pas d\'audio'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Bouton Quiz
            ElevatedButton(
              onPressed: isCompleted
                  ? null // Désactivé si le quiz est terminé
                  : onQuizComplete,
              style: ElevatedButton.styleFrom(
                backgroundColor: isCompleted
                    ? Colors.grey
                    : const Color(0xFF00B46F), // Couleur conditionnelle
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(isCompleted ? 'Quiz terminé' : 'Passer le Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
