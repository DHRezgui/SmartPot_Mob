import 'package:flutter/material.dart';
import 'package:smartpot/models/article.dart';
import 'article_detail_screen.dart';

class AllArticlesScreen extends StatelessWidget {
  const AllArticlesScreen({super.key});

  // Liste d'articles avec la nouvelle structure
  final List<Article> articles = const [
    Article(
      id: '1',
      title: 'Les secrets des succulentes',
      image: 'assets/images/succlents.jpeg',
      author: 'Jean Dupont',
      date: '15 mai 2023',
      content: '''
Les succulentes sont des plantes fascinantes qui stockent l'eau dans leurs feuilles épaisses et charnues, ce qui leur permet de survivre dans des conditions sèches. Adaptées aux climats arides, elles sont parfaites pour les jardiniers débutants grâce à leur faible entretien. Mais attention, même ces plantes robustes ont besoin de soins appropriés pour prospérer.
''',
      tips: [
        'Ensoleillement: 6 heures de lumière indirecte par jour, idéalement près d’une fenêtre orientée sud ou ouest.',
        'Arrosage: Laisser sécher complètement entre les arrosages. En hiver, réduisez l’arrosage pour éviter la pourriture des racines.',
        'Température: Les succulentes préfèrent une température entre 18 et 24°C.',
      ],
      troubleshooting: [
        'Feuilles jaunes: Signe de trop d\'arrosage ou d\'un sol mal drainé. Vérifiez la souplesse des racines.',
        'Étiolement: Besoin de plus de lumière. Déplacez-les vers une source de lumière plus forte.',
        'Feuilles flétries: Cela peut indiquer un manque d’eau ou de nutriments. Arrosez modérément.',
      ],
    ),
    Article(
      id: '2',
      title: 'Guide des plantes d\'intérieur',
      image: 'assets/images/indoor_plants.jpeg',
      author: 'Marie Leroy',
      date: '10 mai 2023',
      content: '''
Les plantes d'intérieur ne sont pas seulement décoratives, elles purifient l'air, régulent l'humidité et apportent une touche de nature à votre environnement. En plus de purifier l'air, elles réduisent le stress et augmentent le bien-être général. Que vous viviez dans un appartement ou une maison, il existe des plantes qui s'adaptent à tous les espaces.
''',
      tips: [
        'Humidité: Vaporiser les feuilles régulièrement, surtout pendant les mois d’hiver, quand l’air est plus sec.',
        'Rotation: Tourner le pot toutes les 2 à 3 semaines pour assurer une croissance uniforme et éviter que la plante ne penche.',
        'Nettoyage: Essuyez les feuilles avec un chiffon humide pour éliminer la poussière et améliorer l’absorption de la lumière.',
      ],
      troubleshooting: [
        'Feuilles jaunies: Cela peut être un signe d’arrosage excessif ou d’un manque de lumière.',
        'Plantes qui ne poussent pas: Essayez de déplacer la plante dans un endroit plus lumineux ou d’ajuster l’arrosage.',
      ],
    ),
    Article(
      id: '3',
      title: 'Entretenir ses plantes en hiver',
      image: 'assets/images/winter_plants.jpeg',
      author: 'Pierre Martin',
      date: '5 mai 2023',
      content: '''
L'hiver peut être une période difficile pour les plantes, surtout avec la diminution de la lumière naturelle et les températures plus froides. Toutefois, avec quelques ajustements, il est possible de maintenir vos plantes en bonne santé pendant cette saison. Veillez à ajuster l’arrosage et à offrir à vos plantes un endroit lumineux et à température contrôlée pour les aider à passer l’hiver.
''',
      tips: [
        'Lumière: Placez vos plantes près d’une fenêtre où elles recevront la lumière directe du soleil, même si ce n’est que quelques heures par jour.',
        'Arrosage: Réduisez l’arrosage pendant l’hiver, car les plantes ne poussent pas autant. Laissez sécher le sol avant d’arroser.',
        'Température: Évitez les courants d’air froid, en particulier autour des fenêtres et des portes. Une température de 15 à 18°C est idéale pour la plupart des plantes d’intérieur.',
      ],
      troubleshooting: [
        'Chute des feuilles: Cela peut être dû à des températures trop basses ou à un manque de lumière.',
        'Croissance ralentie: Réduisez l’arrosage et assurez-vous que la plante ne reçoit pas trop de chaleur.',
        'Plantes qui ne fleurissent pas: Assurez-vous qu’elles reçoivent suffisamment de lumière et qu’elles sont protégées du froid.',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tous les articles',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: const Color(0xFF16A34A),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        itemCount: articles.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final article = articles[index];
          return _buildArticleCard(context, article);
        },
      ),
    );
  }

  Widget _buildArticleCard(BuildContext context, Article article) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _navigateToDetail(context, article),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'article-image-${article.id}',
              child: Image.asset(
                article.image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        article.author,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        article.date,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  if (article.tips != null && article.tips!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6,
                      children: [
                        const Icon(
                          Icons.lightbulb_outline,
                          size: 16,
                          color: Colors.amber,
                        ),
                        Text(
                          '${article.tips!.length} conseils pratiques',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailScreen(article: article),
      ),
    );
  }
}
