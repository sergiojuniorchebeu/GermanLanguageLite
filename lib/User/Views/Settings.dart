import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2/User/Widget//AppBar.dart';
import 'package:projet2/User/Widget//Drawer.dart';
import 'package:projet2/User/Views/Edit%20Profile.dart';
import 'package:share_plus/share_plus.dart';

import 'Paramètre.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF005D80),
      appBar: const CustomAppbar(title: "Paramètres"),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  // Editer profil
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EditProfilePage()),
                    ),
                    child: _buildOptionCard(
                      icon: CupertinoIcons.person,
                      title: 'Éditer le profil',
                    ),
                  ),
                  // Paramètres généraux
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Settings()));
                    },
                    child: _buildOptionCard(
                      icon: CupertinoIcons.settings,
                      title: 'Paramètres',
                      iconColor: Colors.red,
                    ),
                  ),
                  // Aide
                  GestureDetector(
                    onTap: () {
                      _showMessage(context, "Page d'aide à venir !");
                    },
                    child: _buildOptionCard(
                      icon: CupertinoIcons.question_circle,
                      title: 'Aide',
                      iconColor: const Color(0xFFB2CE00),
                    ),
                  ),
                  // Inviter un ami
                  GestureDetector(
                    onTap: () {
                      _inviteFriend(context);  // Appel de la fonction pour inviter un ami
                    },
                    child: _buildOptionCard(
                      icon: CupertinoIcons.person_add,
                      title: 'Inviter un ami',
                      iconColor: const Color(0xFFB2CE00),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    Color iconColor = Colors.black,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFFFDE7D9),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _inviteFriend(BuildContext context) {
    final String invitationMessage = 'Rejoignez-moi sur cette application incroyable ! Voici le lien d\'invitation : [votre-lien-d-invitation]';
    Share.share(invitationMessage);  // Utilisation du package share_plus pour partager le message
  }
}
