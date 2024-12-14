import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson2C6Page extends StatelessWidget {
  const Lesson2C6Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "La coronarographie",
      "content": "\"La coronarographie\" signifie \"Die Koronarangiographie\" en allemand.",
      "examples": [
        {"phrase": "Avant l'intervention", "meaning": "Vor dem Eingriff"},
        {"phrase": "Je vais vous raser le pli de l'aine.", "meaning": "Ich werde Ihre Leistengegend rasieren."},
        {"phrase": "Je vais vous poser une perfusion.", "meaning": "Ich werde Ihnen eine Infusion legen."},
        {"phrase": "Vous serez réveillé durant cette intervention.", "meaning": "Sie werden während des Eingriffs wach sein."},
        {"phrase": "Pendant l'intervention", "meaning": "Während des Eingriffs"},
        {"phrase": "Il faut glisser sur la table.", "meaning": "Sie müssen auf dem Tisch rutschen."},
        {"phrase": "Il faut rester allongé sans bouger.", "meaning": "Sie müssen ruhig liegen bleiben."},
        {"phrase": "Il faut mettre les mains derrière la tête.", "meaning": "Sie müssen die Hände hinter den Kopf legen."},
        {"phrase": "Il faut garder la jambe allongée.", "meaning": "Sie müssen das Bein ausgestreckt halten."},
        {"phrase": "Il faut respirer calmement dans le masque.", "meaning": "Sie müssen ruhig in die Maske atmen."},
        {"phrase": "Il faut inspirer par le nez / expirer par la bouche.", "meaning": "Sie müssen durch die Nase einatmen und durch den Mund ausatmen."},
        {"phrase": "Il faut avaler le médicament.", "meaning": "Sie müssen das Medikament schlucken."},
        {"phrase": "Je vais vous donner / pulvériser un spray sous la langue.", "meaning": "Ich werde Ihnen ein Spray unter die Zunge geben/sprühen."},
        {"phrase": "Je vais vous faire une injection.", "meaning": "Ich werde Ihnen eine Injektion geben."},
        {"phrase": "Vous pouvez ressentir une sensation de chaleur (avoir chaud) à cause du produit de contraste.", "meaning": "Sie können aufgrund des Kontrastmittels ein Wärmegefühl verspüren."},
        {"phrase": "Après l'intervention", "meaning": "Nach dem Eingriff"},
        {"phrase": "Il faudra garder un repos strict au lit pendant 4 à 6 heures.", "meaning": "Sie müssen 4 bis 6 Stunden strikte Bettruhe einhalten."},
        {"phrase": "Il faudra garder un pansement compressif et/ou sac de sable au niveau du pli de l'aine.", "meaning": "Sie müssen einen Kompressionsverband und/oder Sandsack in der Leistengegend behalten."}
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
