import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'title': 'Rappel d\'arrosage',
        'message': 'Il est temps d\'arroser votre Monstera Deliciosa',
        'time': 'Il y a 2 heures',
        'read': false,
      },
      {
        'title': 'Nouvel article',
        'message': 'Découvrez nos conseils pour les plantes en hiver',
        'time': 'Hier',
        'read': true,
      },
      {
        'title': 'Promotion spéciale',
        'message': '20% de réduction sur tous les produits d\'entretien',
        'time': '12/05/2023',
        'read': true,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: const Color(0xFF16A34A),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFF16A34A),
              child: Icon(Icons.notifications, color: Colors.white),
            ),
            title: Text(
              notification['title'] as String,
              style: TextStyle(
                fontWeight:
                    notification['read'] as bool
                        ? FontWeight.normal
                        : FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification['message'] as String),
                const SizedBox(height: 4),
                Text(
                  notification['time'] as String,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            trailing:
                !(notification['read'] as bool)
                    ? const Icon(Icons.circle, size: 10, color: Colors.green)
                    : null,
            onTap: () {
              // Action lorsqu'on clique sur une notification
            },
          );
        },
      ),
    );
  }
}
