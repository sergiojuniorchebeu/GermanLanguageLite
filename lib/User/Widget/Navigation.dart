import 'package:projet2/User/Views/HomeUserPage.dart';
import 'package:flutter/material.dart';

class NavigationHomePage extends StatefulWidget {
  const NavigationHomePage({super.key});

  @override
  State<NavigationHomePage> createState() => _NavigationHomePageState();
}

class _NavigationHomePageState extends State<NavigationHomePage> {
  @override
  Widget build(BuildContext context) {
    return const HomeUserPage();
  }
}
