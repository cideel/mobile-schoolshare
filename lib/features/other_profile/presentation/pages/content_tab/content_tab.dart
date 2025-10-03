import 'package:flutter/material.dart';
import '../../widgets/content_card.dart';
import '../../widgets/empty_state_widget.dart';
import 'package:schoolshare/data/models/users_model.dart';

class ContentTab extends StatelessWidget {
  final UserModel userProfile;

  const ContentTab({super.key, required this.userProfile});

  // Helper untuk kapitalisasi tipe konten
  String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final contentList = userProfile.content ?? [];

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

                // Ambil penulis sesuai tipe konten
                List<String> authors = [];
                if (content.type.toLowerCase() == 'book') {
                  authors = content.authors.isNotEmpty
                      ? content.authors.map((e) => e.name).toList()
                      : [userProfile.name]; // fallback ke pemilik konten
                } else {
                  authors = content.authors.isNotEmpty
                      ? content.authors.map((e) => e.name).toList()
                      : [userProfile.name]; // fallback
                }

                return Padding(
                  padding: EdgeInsets.only(bottom: mq.size.height * 0.015),
                  child: ContentCard(
                    title: content.title,
                    type: capitalize(content.type),
                    authors: authors,
                    views: content.readCount,
                    likes: content.likeCount,
                    date: content.formattedPublishedDate,
                  ),
                );
              },
            ),
    );
  }
}
