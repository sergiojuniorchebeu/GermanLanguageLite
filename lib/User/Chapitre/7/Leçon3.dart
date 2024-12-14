import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson3C7Page extends StatelessWidget {
  const Lesson3C7Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "Les valeurs sanguines",
      "content": "\"Les valeurs sanguines\" signifie \"Die Blutwerte\" en allemand.",
      "examples": [
        {"phrase": "Nous allons vérifier les valeurs sanguines suivantes.", "meaning": "Wir werden die folgenden Blutwerte überprüfen."},
        {"phrase": "La NFS", "meaning": "Das Blutbild"},
        {"phrase": "Les leucocytes (m.)", "meaning": "Die Leukozyten"},
        {"phrase": "L'hémoglobine (f.)", "meaning": "Das Hämoglobin"},
        {"phrase": "Les plaquettes (f.)", "meaning": "Die Blutplättchen / Thrombozyten"},
        {"phrase": "Le ionogramme", "meaning": "Das Ionogramm"},
        {"phrase": "Le sodium", "meaning": "Das Natrium"},
        {"phrase": "Le potassium", "meaning": "Das Kalium"},
        {"phrase": "L'urée (f.)", "meaning": "Der Harnstoff"},
        {"phrase": "La créatinine", "meaning": "Das Kreatinin"},
        {"phrase": "Le cholestérol", "meaning": "Das Cholesterin"},
        {"phrase": "Les triglycérides (m.)", "meaning": "Die Triglyzeride"},
        {"phrase": "La coagulation", "meaning": "Die Gerinnung"},
        {"phrase": "TQ", "meaning": "Quick-Wert"},
        {"phrase": "INR", "meaning": "INR"},
        {"phrase": "TCA", "meaning": "PTT"}
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
