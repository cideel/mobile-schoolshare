import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'content_type_badge.dart';
import 'content_statistics.dart';
import 'content_authors_list.dart';

class ContentCard extends StatelessWidget {
  final Map<String, dynamic> content;
  final VoidCallback onTap;

  const ContentCard({
    super.key,
    required this.content,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: mq.size.height * 0.02),
      child: Card(
        
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: Colors.grey, width: 0.3),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: EdgeInsets.all(mq.size.width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              ContentTypeBadge(
                contentType: content['type'] ?? 'Unknown', 
                typeLabel: content['typeLabel'] ?? 'Unknown'
              ),
              SizedBox(height: mq.size.height * 0.015),
              _buildContentTitle(),
              SizedBox(height: mq.size.height * 0.015),
              ContentAuthorsList(
                authors: content['authors'] != null 
                  ? List<String>.from(content['authors']) 
                  : [], 
                mediaQuery: mq
              ),
              ContentStatistics(content: content, mediaQuery: mq),
            ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentTitle() {
    return Text(
      content['title'] ?? 'Untitled',
      style: AppTextStyle.cardTitle.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        height: 1.3,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
