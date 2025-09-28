import 'package:flutter/material.dart';
import '../../widgets/content_card.dart';
import '../../widgets/empty_state_widget.dart';

class ContentTab extends StatelessWidget {
  const ContentTab({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    // Mock data for demonstration
    final contentList = [
      {
        'title': 'Artificial Intelligence in Education',
        'type': 'Artikel',
        'authors': ['Dr. Jane Smith', 'Prof. Alice Johnson', 'Dr. Robert Brown'],
        'views': 150,
        'likes': 25,
        'date': '2023-10-15',
      },
      {
        'title': 'Machine Learning Research',
        'type': 'Jurnal',
        'authors': ['Dr. John Doe', 'Prof. Alice Johnson', 'Dr. Michael Wilson', 'Prof. Sarah Davis', 'Dr. Emily Chen'],
        'views': 320,
        'likes': 48,
        'date': '2023-09-22',
      },
      {
        'title': 'Data Science Applications in Healthcare',
        'type': 'Paper',
        'authors': ['Dr. Lisa Anderson'],
        'views': 89,
        'likes': 12,
        'date': '2023-08-10',
      },
    ];

    return Padding(
      padding: EdgeInsets.all(mq.size.width * 0.04),
      child: contentList.isEmpty
          ? const EmptyStateWidget(
              title: 'Belum Ada Konten',
              description: 'Pengguna ini belum mempublikasikan konten apapun',
              icon: Icons.article_outlined,
            )
          : ListView.builder(
              itemCount: contentList.length,
              itemBuilder: (context, index) {
                final content = contentList[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: mq.size.height * 0.015),
                  child: ContentCard(
                    title: content['title'] as String,
                    type: content['type'] as String,
                    authors: content['authors'] as List<String>,
                    views: content['views'] as int,
                    likes: content['likes'] as int,
                    date: content['date'] as String,
                  ),
                );
              },
            ),
    );
  }
}
