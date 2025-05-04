import 'package:flutter/material.dart';
import 'package:smartpot/models/article.dart';

class ArticleDetailScreen extends StatefulWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  String? _feedback;

  @override
  Widget build(BuildContext context) {
    final article = widget.article;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: Text(
          article.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF047857),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroImage(article),
            _buildContentSection(article, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroImage(Article article) {
    return Hero(
      tag: 'article-image-${article.id}',
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        child: Image.asset(
          article.image,
          width: double.infinity,
          height: 250,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildContentSection(Article article, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMetaInfo(article, theme),
          const SizedBox(height: 24),
          Text(
            article.content,
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.6,
              fontSize: 16,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 32),
          if (article.tips != null && article.tips!.isNotEmpty)
            _buildTipsSection(article, theme),
          if (article.troubleshooting != null &&
              article.troubleshooting!.isNotEmpty)
            _buildTroubleshootingSection(article, theme),
          const SizedBox(height: 32),
          _buildFeedbackSection(theme),
          if (_feedback != null) _buildFeedbackResult(),
        ],
      ),
    );
  }

  Widget _buildMetaInfo(Article article, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          article.title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.person, color: Colors.grey.shade600, size: 18),
            const SizedBox(width: 4),
            Text(
              article.author,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            const Spacer(),
            Icon(Icons.calendar_today, color: Colors.grey.shade600, size: 18),
            const SizedBox(width: 4),
            Text(
              article.date,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTipsSection(Article article, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '💡 Conseils pratiques',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF16A34A),
          ),
        ),
        const SizedBox(height: 12),
        _buildNumberedList(article.tips!),
      ],
    );
  }

  Widget _buildTroubleshootingSection(Article article, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '🛠️ Dépannage',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFFDC2626),
          ),
        ),
        const SizedBox(height: 12),
        _buildBulletedList(article.troubleshooting!),
      ],
    );
  }

  Widget _buildNumberedList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(items.length, (index) {
        final text = items[index];
        final splitIndex = text.indexOf(':');
        final boldPart =
            splitIndex != -1 ? text.substring(0, splitIndex + 1) : '';
        final normalPart =
            splitIndex != -1 ? text.substring(splitIndex + 1) : text;

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 16,
                height: 1.4,
                color: Colors.black87,
              ),
              children: [
                TextSpan(
                  text: '${index + 1}. ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: boldPart,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: normalPart),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBulletedList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          items.map((text) {
            final splitIndex = text.indexOf(':');
            final boldPart =
                splitIndex != -1 ? text.substring(0, splitIndex + 1) : '';
            final normalPart =
                splitIndex != -1 ? text.substring(splitIndex + 1) : text;

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.4,
                    color: Colors.black87,
                  ),
                  children: [
                    const TextSpan(text: '• '),
                    TextSpan(
                      text: boldPart,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: normalPart),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildFeedbackSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: Colors.grey.shade300),
        const SizedBox(height: 20),
        Text(
          'Cet article vous a-t-il été utile ?',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _handleFeedback('positive'),
                icon: const Icon(Icons.thumb_up_alt_outlined),
                label: const Text('Oui'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _handleFeedback('negative'),
                icon: const Icon(Icons.thumb_down_alt_outlined),
                label: const Text('Non'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeedbackResult() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 32),
      child: Center(
        child: Text(
          _feedback == 'positive'
              ? '😊 Merci pour votre retour !'
              : '☹️ Nous améliorerons cet article !',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  void _handleFeedback(String type) {
    setState(() {
      _feedback = type;
    });

    // 🔒 Envoi possible à Firebase ou autre backend
    // FirebaseAnalytics.instance.logEvent(...);
  }
}
