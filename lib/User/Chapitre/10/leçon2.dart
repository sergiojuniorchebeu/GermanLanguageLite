import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson2C10Page extends StatelessWidget {
  const Lesson2C10Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "La conduite à tenir chez l'adulte",
      "content": "\"La conduite à tenir chez l'adulte\" signifie \"Das Verhalten bei Erwachsenen\" en allemand. Ce guide décrit l'algorithme des situations d'urgence.",
      "examples": [
        {"phrase": "Contrôle de :", "meaning": "Kontrolle von :"},
        {"phrase": "la conscience", "meaning": "Bewusstsein"},
        {"phrase": "la respiration", "meaning": "Atmung"},
        {"phrase": "la circulation/pouls", "meaning": "Kreislauf/Puls"},
        {"phrase": "Numéros d'urgence", "meaning": "Notruf"},
        {"phrase": "Inconscience : Bewusstsein gestört", "meaning": "Respiration et pouls présents = Atmung und Herzschlag vorhanden"},
        {"phrase": "Position latérale de sécurité (PLS)", "meaning": "Stabile Seitenlage"},
        {"phrase": "Arrêt respiratoire", "meaning": "Atemstillstand"},
        {"phrase": "Ventilation", "meaning": "Beatmung"},
        {"phrase": "Arrêt cardio-respiratoire", "meaning": "Herz-Kreislauf-Stillstand"},
        {"phrase": "Réanimation cardio-pulmonaire", "meaning": "Herz-Lungen-Wiederbelebung"},
        {"phrase": "Fréquence : 100 - 120/min", "meaning": "Frequenz : 100 - 120/min"},
        {"phrase": "Profondeur : 5 - 6 cm", "meaning": "Eindringtiefe : 5 - 6 cm"}
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
                return SizedBox(
                  width: double.infinity, // Cette ligne garantit que la Card occupe toute la largeur disponible
                  child: Card(
                    elevation: 6,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[850] // Mode sombre
                        : Colors.white, // Mode clair
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Affichage du texte en allemand (en haut)
                          Text(
                            example["meaning"],
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : const Color(0xFF005D80),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Affichage du texte en français (en bas)
                          Text(
                            example["phrase"],
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white70
                                  : Colors.black54,
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
