import 'package:flutter/material.dart';

class LanguageButton extends StatelessWidget {
  final String flag;
  final String label;

  const LanguageButton({super.key, required this.flag, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      icon: Text(flag, style: const TextStyle(fontSize: 18)),
      label: Text(label, style: const TextStyle(fontSize: 14)),
      onPressed: () {},
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onCardTap;
  final VoidCallback? onTitleTap;
  final VoidCallback? onArrowTap;

  const TaskCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.onCardTap,
    this.onTitleTap,
    this.onArrowTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Avatar et texte
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFFFDE7D9),
                      child: Icon(Icons.group, color: Colors.orange.shade700),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: GestureDetector(
                        onTap: onTitleTap, // Callback spécifique pour le titre
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis, // Empêche le dépassement
                            ),
                            const SizedBox(height: 4),
                            Text(
                              subtitle,
                              style: const TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis, // Empêche le dépassement
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onArrowTap,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
