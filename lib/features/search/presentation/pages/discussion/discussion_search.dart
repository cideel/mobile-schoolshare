import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:schoolshare/models/models.dart';
import 'discussion_detail_page.dart';
import 'create_discussion_page.dart';
import '../../widgets/discussion_widgets/discussion_card.dart';
import '../../widgets/discussion_widgets/create_discussion_button.dart';

class DiscussionSearchResult extends StatelessWidget {
  const DiscussionSearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final List<DiscussionItem> discussions = [
      DiscussionItem(
        id: '1',
        title: 'Bagaimana cara mengoptimalkan performa aplikasi Flutter?',
        content: 'Saya sedang mengembangkan aplikasi Flutter dan mengalami masalah performa...',
        authorName: 'Johan Liebert',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        topic: 'Teknologi',
        authorAvatar: 'assets/images/example-profile.jpg',
        commentCount: 15,
        description: 'Saya sedang mengembangkan aplikasi Flutter dan mengalami masalah performa...',
      ),
      DiscussionItem(
        id: '2',
        title: 'Metode pembelajaran yang efektif untuk era digital',
        content: 'Pendidikan di era digital memerlukan pendekatan yang berbeda...',
        authorName: 'Prof. Sarah Johnson',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        topic: 'Pendidikan',
        authorAvatar: 'assets/images/example-profile-2.jpg',
        commentCount: 8,
        description: 'Mari diskusikan tentang metode pembelajaran terbaru yang sesuai dengan perkembangan teknologi...',
      ),
      DiscussionItem(
        id: '3',
        title: 'Tips menulis paper penelitian yang baik',
        content: 'Sharing pengalaman dalam menulis paper penelitian yang berkualitas...',
        authorName: 'Anggito Setoadji',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        topic: 'Penelitian',
        authorAvatar: 'assets/images/example-profile.jpg',
        commentCount: 23,
        description: 'Sharing pengalaman dalam menulis paper penelitian yang berkualitas...',
      ),
      DiscussionItem(
        id: '4',
        title: 'Implementasi ChatGPT dalam pendidikan',
        content: 'Bagaimana cara mengintegrasikan AI dalam proses belajar mengajar yang efektif...',
        authorName: 'Dr. Sarah Wilson',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        topic: 'AI & Machine Learning',
        authorAvatar: 'assets/images/example-profile-2.jpg',
        commentCount: 42,
        description: 'Bagaimana cara mengintegrasikan AI dalam proses belajar mengajar yang efektif...',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Create Discussion Button
          CreateDiscussionButton(
            onPressed: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: const CreateDiscussionPage(),
                withNavBar: true, // IMPORTANT: This keeps the navbar
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),

          // Discussions List
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: mq.size.width * 0.04,
                vertical: mq.size.height * 0.015,
              ),
              itemCount: discussions.length,
              separatorBuilder: (_, __) => Divider(
                thickness: 0.5,
                color: Colors.grey[300],
                height: mq.size.height * 0.02,
              ),
              itemBuilder: (context, index) {
                final discussion = discussions[index];
                return DiscussionCard(
                  discussion: discussion,
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: DiscussionDetailPage(discussion: discussion),
                      withNavBar: true, // IMPORTANT: This keeps the navbar
                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
