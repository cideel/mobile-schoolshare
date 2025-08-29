import 'package:flutter/material.dart';
import '../../../Models/content_item.dart';
import '../widgets/content_card.dart';
import '../widgets/empty_state_widget.dart';

class ContentTab extends StatelessWidget {
  const ContentTab({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    final List<ContentItem> contentItems = [
      ContentItem(
        title: "Summary of Dawood Mamoon's Work on Chat GPT 4 by Chat GPT 4",
        description: "Video",
        datePosted: "Mei 2024",
        likes: 1593,
        comments: 0,
        contentType: "Video",
        authors: ["Dawood Mamoon", "Christ Marteen", "Anggito Setoadji"],
      ),
      ContentItem(
        title: "Talk Hive -Live Chat: A Realtime AI-Powered Chat Application",
        description: "Artikel",
        datePosted: "April 2025",
        likes: 47,
        comments: 0,
        contentType: "Artikel",
        authors: ["M.K.Jayanthi Kannan", "Radhika Kumbhare"],
      ),
      ContentItem(
        title: "Session 3: Dawood Mamoon and Chat GPT 4: A Relationship with an AI",
        description: "Publikasi",
        datePosted: "Maret 2024",
        likes: 803,
        comments: 0,
        contentType: "Publikasi",
        authors: ["Dawood Mamoon"],
      ),
    ];

    // Jika tidak ada konten, tampilkan empty state
    if (contentItems.isEmpty) {
      return const EmptyStateWidget(
        title: "Belum Ada Konten",
        description: "Pengguna ini belum memposting konten apapun",
      );
    }

    // Jika ada konten, tampilkan list
    return ListView.builder(
      padding: EdgeInsets.all(mq.size.width * 0.04),
      itemCount: contentItems.length,
      itemBuilder: (context, index) {
        return ContentCard(item: contentItems[index]);
      },
    );
  }
}
