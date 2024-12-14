import 'package:flutter/material.dart';

import 'Notifications Services.dart';


class ScheduleNotificationsPage extends StatelessWidget {
  const ScheduleNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Planifier des Notifications')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Planifiez une notification pour le matin
            await NotificationService.scheduleNotification(
              title: 'Bonjour !',
              body: 'Commencez votre journée avec motivation !',
              hour: 8, // 08:00 AM
              minute: 0,
            );

            // Planifiez une notification pour le soir
            await NotificationService.scheduleNotification(
              title: 'Bonsoir !',
              body: 'Prenez un moment pour vous détendre !',
              hour: 20, // 08:00 PM
              minute: 0,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Notifications programmées !')),
            );
          },
          child: const Text('Planifier les Notifications'),
        ),
      ),
    );
  }
}
