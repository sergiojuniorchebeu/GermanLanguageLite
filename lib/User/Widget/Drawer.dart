import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2/User/Views/Edit%20Profile.dart';
import 'package:projet2/User/Views/HomeUserPage.dart';
import 'package:projet2/User/Views/Settings.dart';
import 'package:projet2/User/Widget/Navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';



class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String _userInitial = "G";
  String _userName = "Guest";
  String _userEmail = "none";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('name') ?? "Guest";
      _userEmail = prefs.getString('email') ?? "None";
      _userInitial = _userName.isNotEmpty ? _userName[0].toUpperCase() : "G";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: const Color(0xFF005D80),
            padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
            width: double.infinity,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Text(
                    _userInitial,
                    style: const TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF005D80),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _userEmail,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                // Accueil
                _buildCupertinoDrawerItem(
                  icon: CupertinoIcons.home,
                  title: 'Accueil',
                  onTap: () {
                    if (Navigator.of(context).canPop() &&
                        ModalRoute.of(context)?.settings.name == '/home') {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NavigationHomePage(),
                        ),
                            (route) => false,
                      );
                    }
                  },
                ),
                // Profil
                _buildCupertinoDrawerItem(
                  icon: CupertinoIcons.person,
                  title: 'Profil',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  ),
                ),
                // Livres
                _buildCupertinoDrawerItem(
                  icon: CupertinoIcons.book,
                  title: 'Livres',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeUserPage()),
                  ),
                ),
                const Divider(),
                // Paramètres
                _buildCupertinoDrawerItem(
                  icon: CupertinoIcons.settings,
                  title: 'Paramètres',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget pour les éléments du Drawer
  Widget _buildCupertinoDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: const Color(0xFF005D80),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }
}
