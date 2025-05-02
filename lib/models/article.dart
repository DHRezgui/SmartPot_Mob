class Article {
  final String id;
  final String title;
  final String image;
  final String author;
  final String date;
  final String content;
  final List<String>? tips; // Nouveau champ pour les conseils
  final List<String>? troubleshooting; // Nouveau champ pour le dépannage

  const Article({
    required this.id,
    required this.title,
    required this.image,
    required this.author,
    required this.date,
    required this.content,
    this.tips,
    this.troubleshooting,
  });
}
