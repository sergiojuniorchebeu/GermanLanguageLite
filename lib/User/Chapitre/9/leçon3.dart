import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lesson3C9Page extends StatelessWidget {
  const Lesson3C9Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Leçon data (titre, contenu, exemples)
    final Map<String, dynamic> lessonData = {
      "title": "Les voies d'administration des médicaments",
      "content": "\"Les voies d'administration des médicaments\" signifie \"Die Verabreichungswege von Medikamenten\" en allemand.",
      "examples": [
        {"phrase": "orale = par la bouche", "meaning": "oral = durch den Mund"},
        {"phrase": "les comprimés (m.)", "meaning": "die Tabletten"},
        {"phrase": "les dragées (f.)", "meaning": "die Dragees"},
        {"phrase": "les gélules (f.)", "meaning": "die Kapseln"},
        {"phrase": "les gouttes (f.)", "meaning": "die Tropfen"},
        {"phrase": "le sirop", "meaning": "der Sirup"},
        {"phrase": "sublinguale = laisse fondre sous la langue", "meaning": "sublingual = unter der Zunge zergehen lassen"},
        {"phrase": "les comprimés à croquer (m.)", "meaning": "die Kautabletten"},
        {"phrase": "les comprimés à sucer (m.)", "meaning": "die Lutschtabletten"},
        {"phrase": "les comprimés Lyoc (m.)", "meaning": "die Lyoc-Tabletten"},
        {"phrase": "rectale = administrer en intra rectal", "meaning": "rektal = rektal verabreichen"},
        {"phrase": "le suppositoire", "meaning": "das Zäpfchen"},
        {"phrase": "la lavement", "meaning": "der Einlauf"},
        {"phrase": "intra veineuse = injecter dans la veine", "meaning": "intravenös = in die Vene spritzen"},
        {"phrase": "les perfusions (f.)", "meaning": "die Infusionen"},
        {"phrase": "les injections (f.)", "meaning": "die Injektionen"},
        {"phrase": "intra musculaire = injecter dans le muscle", "meaning": "intramuskulär = in den Muskel spritzen"},
        {"phrase": "cutanée = étaler sur la peau", "meaning": "kutan = auf die Haut auftragen"},
        {"phrase": "la crème", "meaning": "die Creme"},
        {"phrase": "la pommade", "meaning": "die Salbe"},
        {"phrase": "le gel", "meaning": "das Gel"},
        {"phrase": "la pâte", "meaning": "die Paste"},
        {"phrase": "transdermique = coller sur la peau", "meaning": "transdermal = auf die Haut kleben"},
        {"phrase": "un patch", "meaning": "ein Pflaster"},
        {"phrase": "sous-cutanée = injecter sous la peau", "meaning": "subkutan = unter die Haut spritzen"},
        {"phrase": "la perfusion sous-cutanée", "meaning": "die subkutane Infusion"},
        {"phrase": "l'injection sous-cutanée (f.)", "meaning": "die subkutane Injektion"},
        {"phrase": "vaginale = insérer dans le vagin", "meaning": "vaginal = in die Scheide einführen"},
        {"phrase": "conjonctivale = instiller dans l'œil (m.)", "meaning": "konjunktival = ins Auge träufeln"},
        {"phrase": "des gouttes / un collyre", "meaning": "die Tropfen / ein Augentropfen"},
        {"phrase": "une pommade ophtalmique", "meaning": "eine Augensalbe"},
        {"phrase": "nasale = pulvériser dans le nez", "meaning": "nasal = in die Nase sprühen"},
        {"phrase": "le spray nasal", "meaning": "das Nasenspray"},
        {"phrase": "les gouttes nasales (f.)", "meaning": "die Nasentropfen"},
        {"phrase": "inhalation = inhaler par les voies respiratoires", "meaning": "Inhalation = durch die Atemwege inhalieren"},
        {"phrase": "l'aérosol (m.)", "meaning": "das Aerosol"}
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
