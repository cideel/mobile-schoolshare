import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Config/text_styles.dart';
import '../../../Models/discussion_item.dart';
import '../discussion/discussion_detail_page.dart';
import '../discussion/create_discussion_page.dart';

class DiscussionSearchResult extends StatelessWidget {
  const DiscussionSearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    // Dummy data for discussions
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
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(mq.size.width * 0.04),
            color: Colors.grey[50],
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CreateDiscussionPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.componentColor,
                minimumSize: Size(double.infinity, mq.size.height * 0.06),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Icon(
                Icons.add_comment_outlined,
                color: Colors.white,
                size: mq.size.width * 0.05,
              ),
              label: Text(
                'Buat Diskusi Baru',
                style: AppTextStyle.badge.copyWith(fontSize: 14.sp),
              ),
            ),
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
                return _buildDiscussionCard(context, discussion, mq);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscussionCard(BuildContext context, DiscussionItem discussion, MediaQueryData mq) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DiscussionDetailPage(discussion: discussion),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(mq.size.width * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[200]!, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Topic Tag
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: mq.size.width * 0.025,
                vertical: mq.size.height * 0.004,
              ),
              decoration: BoxDecoration(
                color: AppColor.componentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                discussion.topic,
                style: AppTextStyle.caption.copyWith(
                  color: AppColor.componentColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: mq.size.height * 0.012),

            // Title
            Text(
              discussion.title,
              style: AppTextStyle.cardTitle.copyWith(fontSize: 16.sp),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: mq.size.height * 0.008),

            // Description
            Text(
              discussion.description,
              style: AppTextStyle.bodyText.copyWith(
                fontSize: 13.sp,
                color: Colors.grey[600],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: mq.size.height * 0.012),

            // Author and Stats Row
            Row(
              children: [
                // Author Info
                CircleAvatar(
                  radius: mq.size.width * 0.025,
                  backgroundImage: AssetImage(discussion.authorPhoto),
                ),
                SizedBox(width: mq.size.width * 0.02),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        discussion.author,
                        style: AppTextStyle.authorName.copyWith(fontSize: 12.sp),
                      ),
                      Text(
                        _getTimeAgo(discussion.createdAt),
                        style: AppTextStyle.caption.copyWith(
                          fontSize: 11.sp,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),

                // Comment Count
                Row(
                  children: [
                    Icon(
                      Icons.comment_outlined,
                      size: mq.size.width * 0.04,
                      color: Colors.grey[600],
                    ),
                    SizedBox(width: mq.size.width * 0.01),
                    Text(
                      '${discussion.commentCount}',
                      style: AppTextStyle.caption.copyWith(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} hari lalu';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} jam lalu';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} menit lalu';
    } else {
      return 'Baru saja';
    }
  }
}
