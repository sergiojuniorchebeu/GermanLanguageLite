import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2/User/Views/Edit%20Profile.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    // Vérifier si le thème actuel est sombre ou clair
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back, color: isDarkMode ? Colors.white : Colors.black, size: 25),
        ),
        title: const Text(
          'Paramètres',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF005D80),
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Section Paramètres du compte
          _buildSettingsCategory(
            context,
            title: "Compte",
            options: [
              _buildSettingOption(
                context,
                title: "Éditer le profil",
                icon: CupertinoIcons.person,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePage()));
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Section Préférences
          _buildSettingsCategory(
            context,
            title: "Préférences",
            options: [
              _buildSettingOption(
                context,
                title: "Notifications",
                icon: CupertinoIcons.bell,
                onTap: () {
                  // Ajoutez votre logique ici
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Section Support
          _buildSettingsCategory(
            context,
            title: "Support",
            options: [
              _buildSettingOption(
                context,
                title: "Aide",
                icon: CupertinoIcons.question_circle,
                onTap: () {
                  // Ajoutez votre logique ici
                },
              ),
              _buildSettingOption(
                context,
                title: "Envoyer des commentaires",
                icon: CupertinoIcons.envelope,
                onTap: () {
                  // Ajoutez votre logique ici
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget pour une section de paramètres
  Widget _buildSettingsCategory(
      BuildContext context, {
        required String title,
        required List<Widget> options,
      }) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;  // Vérification du mode sombre

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : const Color(0xFF005D80), // Adaptation de la couleur selon le mode
          ),
        ),
        const SizedBox(height: 10),
        Card(
          color: isDarkMode ? Colors.black : Colors.white, // Change la couleur du fond de la carte
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(children: options),
        ),
      ],
    );
  }

  // Widget pour une option de paramètre
  Widget _buildSettingOption(
      BuildContext context, {
        required String title,
        required IconData icon,
        required VoidCallback onTap,
        Color iconColor = Colors.black,
        bool isLast = false,
      }) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;  // Vérification du mode sombre

    return Column(
      children: [
        ListTile(
          leading: Icon(icon, size: 28, color: isDarkMode ? Colors.white : iconColor),  // Changer la couleur de l'icône selon le mode
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white : Colors.black, // Adaptation de la couleur du texte
            ),
          ),
          trailing: Icon(CupertinoIcons.chevron_forward, size: 20, color: isDarkMode ? Colors.white : Colors.black), // Icône de chevron colorée selon le mode
          onTap: onTap,
        ),
        if (!isLast)
          Divider(
            height: 1,
            thickness: 1,
            indent: 16,
            endIndent: 16,
            color: isDarkMode ? Colors.white38 : Colors.black12, // Changer la couleur du séparateur
          ),
      ],
    );
  }
}
