import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson1C5Page extends StatelessWidget {
  const Lesson1C5Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "L'observation",
      "content": "\"L'observation\" signifie \"Die Beobachtung\" en allemand.",
      "examples": [
        {"phrase": "Une pâleur", "meaning": "Eine Blässe"},
        {"phrase": "Une cyanose", "meaning": "Eine Zyanose"},
        {"phrase": "Une rougeur", "meaning": "Eine Rötung"},
        {"phrase": "Un ictère", "meaning": "Gelbsucht (f.) / Ikterus (m.)"},
        {"phrase": "De la sueur", "meaning": "Schweiß (m.)"},
        {"phrase": "Un saignement", "meaning": "Eine Blutung"},
        {"phrase": "Une toux", "meaning": "Husten (m.)"},
        {"phrase": "Une dyspnée / une détresse respiratoire", "meaning": "Dyspnoe (f.) / Atemnot (f.)"},
        {"phrase": "Une hypothermie", "meaning": "Eine Unterkühlung / eine Hypothermie"},
        {"phrase": "Une agitation", "meaning": "Unruhe (f.)"},
        {"phrase": "Une confusion", "meaning": "Eine Verwirrtheit"},
        {"phrase": "Des hallucinations (f.)", "meaning": "Ein Delir"},
        {"phrase": "Une paralysie / une hémiplégie", "meaning": "Eine Lähmung / eine Halbseitenlähmung"},
        {"phrase": "Une somnolence", "meaning": "Eine Schläfrigkeit / eine Somnolenz"},
        {"phrase": "Un tremblement", "meaning": "Ein Zittern"},
        {"phrase": "Une inhalation", "meaning": "Eine Inhalation"},
        {"phrase": "Une fausse route", "meaning": "Eine Fehlschlucken"},
        {"phrase": "Un malaise / un malaise vagal", "meaning": "Ein Unwohlsein / ein Vasovagale"},
        {"phrase": "Une perte de connaissance / une inconscience", "meaning": "Ein Bewusstseinsverlust / eine Ohnmacht"}
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
