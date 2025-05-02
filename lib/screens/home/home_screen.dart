import 'package:flutter/material.dart';
import 'ask_ai_screen.dart';
import 'notification_screen.dart';
import 'all_articles.dart';
import 'article_detail_screen.dart';
import 'plant_category_screen.dart';
import 'dashboard.dart';
import 'package:smartpot/screens/plant/plants_list_screen.dart';
import 'package:smartpot/screens/account/my_profile_screen.dart';
import 'search_screen.dart';
import 'package:smartpot/widgets/custom_bottom_navbar.dart';
import 'package:smartpot/models/article.dart';

class Category {
  final String title;
  final String image;

  Category({required this.title, required this.image});
}

void main() {
  runApp(const PlantifyApp());
}

class PlantifyApp extends StatelessWidget {
  const PlantifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plantify',
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Inter'),
      home: const PlantifyHomePage(),
      debugShowCheckedModeBanner: false,
      // Routes définies
      routes: {
        '/ask_ai': (context) => const AskAiScreen(),
        '/notifications': (context) => const NotificationScreen(),
        '/all_articles': (context) => const AllArticlesScreen(),
        '/home':
            (context) => const PlantifyHomePage(), // Route pour l'écran Home
        '/dashboard':
            (context) =>
                const DashboardScreen(), // Assure-toi d'avoir l'écran dashboard
        '/my_plants':
            (context) =>
                const MyPlantsScreen(), // Assure-toi d'avoir l'écran MyPlants
        '/account':
            (context) =>
                const AccountScreen(), // Assure-toi d'avoir l'écran Account
        '/plant_category':
            (context) => const PlantCategoryScreen(), // Nouvelle route
      },
    );
  }
}

class PlantifyHomePage extends StatefulWidget {
  const PlantifyHomePage({super.key});

  @override
  State<PlantifyHomePage> createState() => _PlantifyHomePageState();
}

class _PlantifyHomePageState extends State<PlantifyHomePage> {
  int currentIndex = 0;

  // Liste des articles populaires
  List<Article> popularArticles = [];

  @override
  void initState() {
    super.initState();
    loadArticles(); // appel de fonction pour charger les données
  }

  void loadArticles() {
    popularArticles = [
      Article(
        id: '1',
        title: 'Unlock the Secrets of Succulents: Care Tips for...',
        image: 'assets/images/succlents.jpeg',
        author: 'Jane Doe',
        date: '2024-05-01',
        content:
            'Succulents are low-maintenance plants that thrive in dry conditions...',
        tips: ['Use well-draining soil', 'Water only when soil is dry'],
        troubleshooting: ['Leaves falling off', 'Root rot'],
      ),
      Article(
        id: '2',
        title: 'The Ultimate Guide to Indoor Plants: From...',
        image: 'assets/images/indoor_plants.jpeg',
        author: 'John Smith',
        date: '2024-04-20',
        content: 'Indoor plants purify the air and add a touch of nature...',
        tips: ['Place near sunlight', 'Avoid overwatering'],
        troubleshooting: ['Yellowing leaves', 'Pest infestation'],
      ),
    ];
    setState(() {}); // Met à jour l'affichage
  }

  Widget buildPopularArticle(Article article) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => ArticleDetailScreen(
                  article: article,
                ), // Passe l'objet article ici
          ),
        );
      },
      child: SizedBox(
        width: 160,
        height: 120,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                article.image,
                height: 80,
                width: 160,
                fit: BoxFit.cover,
                semanticLabel: article.title,
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Text(
                article.title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildExplorePlantItem(
    String imageAsset,
    String label,
    String semanticLabel,
    String categoryId, // Ajout d'un ID pour la catégorie
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/plant_category',
          arguments: categoryId, // Passer l'ID de la catégorie
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Image.asset(
              imageAsset,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
              semanticLabel: semanticLabel,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final greenColor = const Color(0xFF16A34A);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        selectedColor: greenColor,
        unselectedColor: Colors.grey.shade600,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.eco, color: greenColor, size: 24),
                      const SizedBox(width: 6),
                      const Text(
                        'Plantify',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_none),
                    color: Colors.grey.shade700,
                    onPressed: () {
                      Navigator.pushNamed(context, '/notifications');
                    },
                    tooltip: 'Notifications',
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Search bar
              Builder(
                builder: (context) {
                  return TextField(
                    onChanged: (text) {
                      if (text.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchScreen(),
                          ),
                        );
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Search plants..',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade400,
                        size: 18,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Popular Articles header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Articles',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/all_articles');
                    },
                    icon: Text(
                      'View All',
                      style: TextStyle(
                        color: greenColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    label: Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: greenColor,
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(50, 20),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Popular Articles list
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children:
                      popularArticles
                          .map(
                            (article) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: buildPopularArticle(article),
                            ),
                          )
                          .toList(),
                ),
              ),

              const SizedBox(height: 20),

              // Ask Plant AI
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/ai.png',
                      width: 56,
                      height: 56,
                      semanticLabel:
                          'Illustration of two people with a large question mark symbolizing plant experts',
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Ask Plant Ai',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Our ai agent is ready to help with your problems.',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/ask_ai');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: greenColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: const Text('Ask the Ai'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Explore Plants header
              const Text(
                'Explore Plants',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 8),

              // Explore Plants grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 3.5,
                padding: const EdgeInsets.only(bottom: 20),
                children: [
                  buildExplorePlantItem(
                    'assets/images/cactus.png',
                    'Succulents & Cacti',
                    'Small green succulent plant in a white pot',
                    'succulents', // ID de la catégorie
                  ),
                  buildExplorePlantItem(
                    'assets/images/flower.png',
                    'Flowering Plants',
                    'Flowering plant with pink flowers in a white pot',
                    'flowering',
                  ),
                  buildExplorePlantItem(
                    'assets/images/foliage.png',
                    'Foliage Plants',
                    'Green foliage plant with broad leaves in a white pot',
                    'foliage',
                  ),
                  buildExplorePlantItem(
                    'assets/images/tree.png',
                    'Trees',
                    'Small green tree with a thick trunk',
                    'trees',
                  ),
                  buildExplorePlantItem(
                    'assets/images/shrubs.png',
                    'Weeds & Shrubs',
                    'Green weeds and shrubs plant in a white pot',
                    'shrubs',
                  ),
                  buildExplorePlantItem(
                    'assets/images/fruits.png',
                    'Fruits',
                    'Bowl of fresh fruits including tomatoes and strawberries',
                    'fruits',
                  ),
                  buildExplorePlantItem(
                    'assets/images/vegetables.png',
                    'Vegetables',
                    'Fresh vegetables including tomatoes and peppers in a bowl',
                    'vegetables',
                  ),
                  buildExplorePlantItem(
                    'assets/images/herbs.png',
                    'Herbs',
                    'Green herb plant in a white pot',
                    'herbs',
                  ),
                  buildExplorePlantItem(
                    'assets/images/mushroom.png',
                    'Mushrooms',
                    'Brown mushrooms cluster',
                    'mushrooms',
                  ),
                  buildExplorePlantItem(
                    'assets/images/poisonous.png',
                    'Toxic Plants',
                    'Green toxic plant in a white pot',
                    'toxic',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
