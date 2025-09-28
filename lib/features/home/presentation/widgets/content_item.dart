import 'package:flutter/material.dart';
import '../../../../models/content.dart';
import 'content_header.dart';
import 'content_card.dart';
import 'content_action_buttons.dart';

class ContentItem extends StatelessWidget {
  final Content content;
  final int index;

  const ContentItem({
    Key? key,
    required this.content,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Padding(
      padding: EdgeInsets.symmetric(vertical: mq.size.height * 0.02),
      child: Column(
        children: [
          const Divider(thickness: 0.5, color: Colors.grey),
          SizedBox(height: mq.size.height * 0.01),
          
          // Content Header (Author Profile & Institution)
          ContentHeader(
            authors: content.authors,
            institutionName: content.institutionName,
          ),
          
          SizedBox(height: mq.size.height * 0.015),
          
          // Main Content Card
          ContentCard(
            title: content.title,
            type: content.type,
            publishedDate: content.createdAt,
            authors: content.authors,
            readCount: content.viewCount,
            downloadCount: content.downloadCount,
            likeCount: content.recommendationCount,
          ),
          
          SizedBox(height: mq.size.height * 0.015),
          
          // Action Buttons
          ContentActionButtons(
            contentTitle: content.title,
            onBookmarkTap: () => _handleBookmarkAction(),
            onRecommendTap: () => _handleRecommendAction(),
            onShareTap: () => _handleShareAction(),
          ),
          
          const Divider(thickness: 1),
        ],
      ),
    );
  }

  // Action handlers
  void _handleBookmarkAction() {
    print("Bookmark tapped for: ${content.title}");
  }

  void _handleRecommendAction() {
    print("Recommend tapped for: ${content.title}");
  }

  void _handleShareAction() {
    print("Share tapped for: ${content.title}");
  }
}
