import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson3C10Page extends StatelessWidget {
  const Lesson3C10Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "La prise en charge complémentaire",
      "content": "\"La prise en charge complémentaire\" signifie \"Die zusätzlichen Maßnahmen\" en allemand. Ce guide explique les mesures complémentaires à prendre en charge en cas d'urgence, incluant l'observation de la respiration et l'administration d'oxygène.",
      "examples": [
        {"phrase": "Je vais mesurer la fréquence respiratoire et la saturation en oxygène.", "meaning": "Ich werde die Atemfrequenz und die Sauerstoffsättigung messen."},
        {"phrase": "Je vais observer la respiration :", "meaning": "Ich werde das Atmen beobachten:"},
        {"phrase": "Hyper/Hypoventilation", "meaning": "Hyper-/Hypoventilation"},
        {"phrase": "Respiration paradoxale", "meaning": "Paradoxe Atmung"},
        {"phrase": "Pause respiratoire", "meaning": "Atempause"},
        {"phrase": "Apnée", "meaning": "Atemstillstand"},
        {"phrase": "Je vais vous mettre de l’oxygène avec :", "meaning": "Ich werde Ihnen Sauerstoff geben mit:"},
        {"phrase": "Une sonde nasale", "meaning": "Einer Nasensonde"},
        {"phrase": "Des lunettes à oxygène", "meaning": "Einer Sauerstoffbrille"},
        {"phrase": "Un masque à oxygène", "meaning": "Einer Sauerstoffmaske"},
        {"phrase": "Une VNI (ventilation non invasive)", "meaning": "Einer NIV (nicht-invasive Beatmung)"},
        {"phrase": "Un ballon de ventilation (BAVU)", "meaning": "Dem Beatmungsbeutel (BAVU)"},
        {"phrase": "Je vais vous poser un aérosol.", "meaning": "Ich werde Ihnen ein Aerosol geben."},
        {"phrase": "Je vais vous poser une canule de Guedel/canule de Wendel.", "meaning": "Ich werde Ihnen eine Guedel-Kanüle/Wendel-Kanüle legen."},
        {"phrase": "Je vais vous aspirer en endotrachéale (par le nez / par la bouche).", "meaning": "Ich werde Sie endotracheal absaugen (durch die Nase / durch den Mund)."},
        {"phrase": "Aspiration endo-trachéale.", "meaning": "Endotracheale Absaugung."}
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
