import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../../../data/models/discussion_item.dart';
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
        topic: 'Teknologi',
        title: 'Bagaimana cara mengoptimalkan performa aplikasi Flutter?',
        author: 'Johan Liebert',
        authorPhoto: 'assets/images/example-profile.jpg',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        commentCount: 15,
        description: 'Saya sedang mengembangkan aplikasi Flutter dan mengalami masalah performa...',
      ),
      DiscussionItem(
        id: '2',
        topic: 'Pendidikan',
        title: 'Metode pembelajaran yang efektif untuk era digital',
        author: 'Ratandi Ahmad Fauzan',
        authorPhoto: 'assets/images/example-profile-2.jpg',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        commentCount: 8,
        description: 'Mari diskusikan tentang metode pembelajaran terbaru yang sesuai dengan perkembangan teknologi...',
      ),
      DiscussionItem(
        id: '3',
        topic: 'Penelitian',
        title: 'Tips menulis paper penelitian yang baik',
        author: 'Anggito Setoadji',
        authorPhoto: 'assets/images/example-profile.jpg',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        commentCount: 23,
        description: 'Sharing pengalaman dalam menulis paper penelitian yang berkualitas...',
      ),
      DiscussionItem(
        id: '4',
        topic: 'AI & Machine Learning',
        title: 'Implementasi ChatGPT dalam pendidikan',
        author: 'Dr. Sarah Wilson',
        authorPhoto: 'assets/images/example-profile-2.jpg',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
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
