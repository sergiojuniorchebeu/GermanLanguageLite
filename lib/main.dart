import 'package:flutter/material.dart';
import 'User/LauncherPage.dart';
import 'User/Notifications/Notifications Services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'German Language',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        fontFamily: "Poppins",
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF005D80)),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const FirstLaunchHandler(),
    );
  }
}


