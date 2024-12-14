import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson1C4Page extends StatelessWidget {
  const Lesson1C4Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "Les soins corporels (m.)",
      "content": "\"Les soins corporels\" signifie \"Die Körperpflege\" en allemand.",
      "examples": [
        {"phrase": "La toilette complète", "meaning": "Die vollständige Körperpflege"},
        {"phrase": "La toilette partielle au lit / au lavabo", "meaning": "Die Teilkörperpflege im Bett / am Waschbecken"},
        {"phrase": "Avez-vous besoin d’aide pour la toilette ?", "meaning": "Brauchen Sie Hilfe bei der Körperpflege?"},
        {"phrase": "Pouvez-vous vous laver seul / êtes-vous autonome ?", "meaning": "Können Sie sich selbst waschen? / Sind Sie selbstständig?"},
        {"phrase": "Dois-je faire une toilette complète ?", "meaning": "Soll ich eine vollständige Körperpflege durchführen?"},
        {"phrase": "Est-ce que vous arrivez à vous laver le dos ?", "meaning": "Können Sie sich den Rücken selbst waschen?"},
        {"phrase": "Dois-je faire la toilette au lit ?", "meaning": "Soll ich die Körperpflege im Bett machen?"},
        {"phrase": "Dois-je vous accompagner aux toilettes ?", "meaning": "Soll ich Sie zur Toilette begleiten?"}
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
