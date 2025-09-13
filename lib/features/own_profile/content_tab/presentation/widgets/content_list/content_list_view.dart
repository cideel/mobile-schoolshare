import 'package:flutter/material.dart';
import '../../../../../../data/models/publication.dart';
import 'content_card.dart';
import 'content_list_header.dart';

class ContentListView extends StatelessWidget {
  final List<Publication> content;
  final VoidCallback onAddPressed;
  final Function(Publication) onContentTap;

  const ContentListView({
    super.key,
    required this.content,
    required this.onAddPressed,
    required this.onContentTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContentListHeader(
          contentCount: content.length,
          onAddPressed: onAddPressed,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: content.length,
            itemBuilder: (context, index) => ContentCard(
              content: _publicationToMap(content[index]),
              onTap: () => onContentTap(content[index]),
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to convert Publication to Map for ContentCard
  Map<String, dynamic> _publicationToMap(Publication publication) {
    return {
      'title': publication.title,
      'type': publication.type,
      'typeLabel': publication.type,
      'authors': publication.authors,
      'publishedDate': _formatDate(publication.publishedDate),
      'dibaca': publication.readCount,
      'diunduh': 0, // Default value, can be added to Publication model later
      'dibagikan': 0, // Default value, can be added to Publication model later
      'rekomendasi': publication.likeCount,
    };
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agt', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
