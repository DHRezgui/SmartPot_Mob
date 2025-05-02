import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
//import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/home/home_screen.dart';
import '../models/article.dart';
import 'screens/home/plant_category_screen.dart';
import 'screens/home/all_articles.dart';
import 'screens/home/ask_ai_screen.dart';
import 'screens/home/article_detail_screen.dart';
import 'screens/home/notification_screen.dart';
import 'package:smartpot/screens/home/dashboard.dart';
import 'package:smartpot/screens/plant/plants_list_screen.dart';
import 'package:smartpot/screens/account/my_profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const PlantifyApp());
}

class PlantifyApp extends StatelessWidget {
  const PlantifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plantify',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // écran de démarrage
      routes: {
        '/home': (context) => const PlantifyHomePage(),
        '/plant_category': (context) => const PlantCategoryScreen(),
        '/all_articles': (context) => const AllArticlesScreen(),
        '/ask_ai': (context) => const AskAiScreen(),
        '/article_detail':
            (context) => ArticleDetailScreen(
              article: ModalRoute.of(context)!.settings.arguments as Article,
            ),
        '/notifications': (context) => const NotificationScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/my_plants': (context) => MyPlantsScreen(),
        '/account': (context) => AccountScreen(),
      },
      // Gestion des routes non trouvées
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder:
              (context) => Scaffold(
                body: Center(child: Text('Page non trouvée: ${settings.name}')),
              ),
        );
      },
    );
  }
}
