import 'package:flutter/material.dart';
import 'package:smartpot/widgets/custom_bottom_navbar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int bottomNavIndex = 2;
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

    const green700 = Color(0xFF047857); // Couleur verte de ton application
    const gray300 = Color(
      0xFFD1D5DB,
    ); // Couleur grise pour les notifications lues
    const gray500 = Color(0xFF6B7280); // Couleur grise plus sombre

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Image.asset(
            'assets/images/logoApp1.png',
            width: 24,
            height: 24,
            fit: BoxFit.contain,
            semanticLabel: 'App logo',
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(color: gray300),
                color: gray300,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: green700,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Notifications (${notifications.length})',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          notifications.isEmpty
              ? Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/logoApp1.png',
                        width: 64,
                        height: 64,
                        fit: BoxFit.contain,
                        semanticLabel: 'App logo centered',
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'No New Notifications',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              : Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: const Icon(
                          Icons.notifications,
                          color: green700,
                          size: 40,
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
                              style: const TextStyle(
                                fontSize: 12,
                                color: gray500,
                              ),
                            ),
                          ],
                        ),
                        trailing:
                            !(notification['read'] as bool)
                                ? const Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: Colors.green,
                                )
                                : null,
                        onTap: () {
                          // Action lors du clic sur la notification
                          // Par exemple, marquer la notification comme lue ou naviguer vers une autre page.
                        },
                      ),
                    );
                  },
                ),
              ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: bottomNavIndex,
        selectedColor: green700,
        unselectedColor: gray500,
        selectedFontSize: 12,
        unselectedFontSize: 10,
      ),
    );
  }
}
