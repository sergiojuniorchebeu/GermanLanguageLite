import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson3C8Page extends StatelessWidget {
  const Lesson3C8Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "La surveillance post opératoire",
      "content": "\"La surveillance post opératoire\" signifie \"Die postoperative Überwachung\" en allemand.",
      "examples": [
        {"phrase": "Je vais vérifier vos constantes vitales.", "meaning": "Ich werde Ihre Vitalwerte überprüfen."},
        {"phrase": "Avez-vous des douleurs ?", "meaning": "Haben Sie Schmerzen?"},
        {"phrase": "Pouvez-vous bouger vos jambes ?", "meaning": "Können Sie Ihre Beine bewegen?"},
        {"phrase": "Est-ce que vous ressentez des nausées ou des vomissements ?", "meaning": "Haben Sie Übelkeit oder Erbrechen?"},
        {"phrase": "Je vais contrôler votre pansement.", "meaning": "Ich werde Ihren Verband kontrollieren."},
        {"phrase": "Je vais vérifier votre perfusion.", "meaning": "Ich werde Ihre Infusion überprüfen."},
        {"phrase": "Il faudra signaler toute douleur ou inconfort.", "meaning": "Sie müssen jede Art von Schmerzen oder Unwohlsein melden."},
        {"phrase": "Je vais vous aider à vous mobiliser progressivement.", "meaning": "Ich werde Ihnen helfen, sich allmählich zu mobilisieren."},
        {"phrase": "Nous allons prévenir les risques de complications post-opératoires.", "meaning": "Wir werden das Risiko postoperativer Komplikationen vorbeugen."},
        {"phrase": "L'opération s'est bien passée, il n'y a pas eu de complications.", "meaning": "Die Operation ist gut verlaufen, es gab keine Komplikationen."},
        {"phrase": "On vous a mis un sac de sable, un pansement compressif ou une vessie de glace.", "meaning": "Man hat Ihnen einen Sandsack, einen Kompressionsverband oder eine Eisblase angelegt."},
        {"phrase": "Vous devez rester couché au lit.", "meaning": "Sie müssen im Bett liegen bleiben."},
        {"phrase": "Le premier lever se fera avec un infirmier ou une infirmière.", "meaning": "Das erste Aufstehen erfolgt mit einem Krankenpfleger oder einer Krankenschwester."},
        {"phrase": "Je vais surveiller :", "meaning": "Ich werde überwachen:"},
        {"phrase": "La fréquence cardiaque / le pouls", "meaning": "Die Herzfrequenz / der Puls"},
        {"phrase": "La diurèse", "meaning": "Die Urinausscheidung"},
        {"phrase": "Le drainage", "meaning": "Die Drainage"},
        {"phrase": "Le pansement / les pansements", "meaning": "Der Verband / die Verbände"},
        {"phrase": "Je vais regarder votre pansement / vos pansements et voir si tout est normal.", "meaning": "Ich werde Ihren Verband / Ihre Verbände ansehen und prüfen, ob alles in Ordnung ist."},
        {"phrase": "Il peut y avoir un saignement / un hématome.", "meaning": "Es kann eine Blutung oder ein Hämatom geben."}
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
