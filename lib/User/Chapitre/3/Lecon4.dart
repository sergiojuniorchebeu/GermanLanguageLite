import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson4C4Page extends StatelessWidget {
  const Lesson4C4Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "Les éliminations",
      "content": "\"Les éliminations\" signifie \"Die Ausscheidungen\" en allemand.",
      "examples": [
        {"phrase": "Les urines", "meaning": "Der Harn"},
        {"phrase": "Combien de fois urinez-vous par jour ? Une grande / petite quantité.", "meaning": "Wie oft urinieren Sie täglich? Viel / wenig Urin."},
        {"phrase": "Avez-vous des brûlures mictionnelles ?", "meaning": "Haben Sie beim Wasserlassen ein Brennen?"},
        {"phrase": "Est-ce que vous sentez une pression au niveau de la vessie ?", "meaning": "Spüren Sie einen Druck in der Blase?"},
        {"phrase": "Avez-vous des urines concentrées ?", "meaning": "Haben Sie konzentrierten Urin?"},
        {"phrase": "Est-ce que vous retenez une petite quantité d’urine ou perdez-vous de l’urine en position couchée ?", "meaning": "Halten Sie ein bisschen Urin zurück oder verlieren Sie Urin im Liegen?"},
        {"phrase": "Pouvez-vous uriner en position couchée ?", "meaning": "Können Sie im Liegen urinieren?"},
        {"phrase": "Avez-vous besoin d’un urinal / bassin ?", "meaning": "Brauchen Sie einen Harnflasche oder eine Bettpfanne?"},
        {"phrase": "Est-ce que vous arrivez à utiliser un urinal / bassin couché(e) ?", "meaning": "Können Sie ein Urinal oder eine Bettpfanne im Liegen benutzen?"},
        {"phrase": "Les selles / le transit", "meaning": "Der Stuhlgang / die Verdauung"},
        {"phrase": "De quand date votre dernière selle ?", "meaning": "Wann war Ihr letzter Stuhlgang?"},
        {"phrase": "Avez-vous des diarrhées / êtes constipé(e) ?", "meaning": "Haben Sie Durchfall? Sind Sie verstopft?"},
        {"phrase": "Avez-vous du sang dans les selles ?", "meaning": "Haben Sie Blut im Stuhl?"},
        {"phrase": "Est-ce que votre transit intestinal est complet ?", "meaning": "Ist Ihr Stuhlgang vollständig?"},
        {"phrase": "Les nausées (f.) / les vomissements (m.)", "meaning": "Die Übelkeit / das Erbrechen"},
        {"phrase": "Avez-vous envie de vomir ?", "meaning": "Ist Ihnen übel?"},
        {"phrase": "Avez-vous des nausées ?", "meaning": "Haben Sie Übelkeit?"},
        {"phrase": "Avez-vous déjà vomi ?", "meaning": "Haben Sie sich schon übergeben?"}
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
