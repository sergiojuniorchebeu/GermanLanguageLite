import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet2/User/Views/HomeUserPage.dart';
import 'package:projet2/User/Views/Settings.dart';

class NavigationHomePage extends StatefulWidget {
  const NavigationHomePage({super.key});

  @override
  State<NavigationHomePage> createState() => _NavigationHomePageState();
}

class _NavigationHomePageState extends State<NavigationHomePage> {

  final List<Widget> _screens = [
    const HomeUserPage(),
    //const AdmissionPapersPage(),
    const SettingsPage()
  ];

  int _currentIndex = 0;

  void _changescreen(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Vérification du mode actuel (sombre ou clair)
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: const Color(0xFF005D80),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[850] : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: "Home",
            ),
            /*BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.book),
              label: "Info",
            ),*/
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              label: "Localisation",
            ),
          ],
          currentIndex: _currentIndex,
          selectedItemColor: isDarkMode ? Colors.blueAccent : Colors.blueAccent,
          unselectedItemColor: isDarkMode ? Colors.white70 : Colors.black,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _changescreen,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
