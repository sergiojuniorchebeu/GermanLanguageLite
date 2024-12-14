import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson1C3Page extends StatelessWidget {
  const Lesson1C3Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "Les différents régimes",
      "content": "\"Les différents régimes\" signifie \"Die verschiedenen Diäten\" en allemand.",
      "examples": [
        {"phrase": "Est-ce que vous pouvez tout manger/boire ?", "meaning": "Können Sie alles essen/trinken?"},
        {"phrase": "Un régime normal", "meaning": "Eine Normalkost"},
        {"phrase": "Un régime léger", "meaning": "Eine leichte Kost"},
        {"phrase": "Un régime mixé", "meaning": "Eine pürierte Kost"},
        {"phrase": "Un régime sans sel", "meaning": "Eine salzarme Diät"},
        {"phrase": "Un régime diabétique", "meaning": "Eine Diabetesdiät"},
        {"phrase": "Un régime végétarien / vegan", "meaning": "Eine vegetarische / vegane Ernährung"},
        {"phrase": "Un régime hyperprotéiné", "meaning": "Eine eiweißreiche Diät"},
        {"phrase": "Un régime sans gluten", "meaning": "Eine glutenfreie Diät"},
        {"phrase": "Un régime sans porc", "meaning": "Eine Schweinefleisch-freie Kost"},
        {"phrase": "Un régime sans résidu", "meaning": "Eine ballaststoffarme Diät"},
        {"phrase": "Avez-vous un régime alimentaire spécifique ?", "meaning": "Haben Sie eine spezielle Diät?"},
        {"phrase": "Avez-vous une prothèse dentaire ?", "meaning": "Haben Sie eine Zahnprothese?"}
      ],
    };

    return Scaffold(
      backgroundColor: const Color(0xFF01799B),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        title: Text(
          lessonData["title"],
          style: GoogleFonts.poppins(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF005D80),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF005D80), Color(0xFF01799B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section: Titre de la leçon
              Text(
                lessonData["title"],
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              // Contenu principal
              Text(
                lessonData["content"],
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 16),
              // Liste des exemples
              ...lessonData["examples"].map<Widget>((example) {
                // Détection du mode sombre
                bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

                return SizedBox(
                  width: double.infinity, // Cette ligne garantit que la Card occupe toute la largeur disponible
                  child: Card(
                    elevation: 6,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: isDarkMode ? Colors.grey[800] : Colors.white, // Couleur de la carte selon le mode
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Texte en allemand en haut
                          Text(
                            example["meaning"],
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : const Color(0xFF005D80), // Couleur du texte selon le mode
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Texte en français en bas
                          Text(
                            example["phrase"],
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: isDarkMode ? Colors.white70 : Colors.black54, // Couleur du texte selon le mode
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
