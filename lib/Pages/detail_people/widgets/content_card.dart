import 'package:flutter/material.dart';
import 'package:schoolshare/Config/color.dart';
import '../../../Config/text_styles.dart';
import '../../../Models/content_item.dart';

class ContentCard extends StatelessWidget {
  final ContentItem item;

  const ContentCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: mq.size.height * 0.015),
      padding: EdgeInsets.all(mq.size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: AppTextStyle.subtitle.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: mq.size.height * 0.008),
          
          // Content type badge
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: mq.size.width * 0.025,
              vertical: mq.size.height * 0.004,
            ),
            decoration: BoxDecoration(
              color: AppColor.componentColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              item.contentType,
              style: AppTextStyle.caption.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          
          SizedBox(height: mq.size.height * 0.01),
          
          // Date
          Text(
            item.datePosted,
            style: AppTextStyle.caption.copyWith(
              color: Colors.grey[600],
            ),
          ),
          
          SizedBox(height: mq.size.height * 0.008),
          
          // Authors with avatars
          Wrap(
            spacing: mq.size.width * 0.02,
            runSpacing: mq.size.height * 0.005,
            children: item.authors.take(3).map((author) => Container(
              constraints: BoxConstraints(
                maxWidth: mq.size.width * 0.4,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: mq.size.width * 0.025,
                    backgroundColor: Colors.grey[300],
                    child: Text(
                      author.split(' ').map((name) => name.isNotEmpty ? name[0] : '').join(''),
                      style: TextStyle(
                        fontSize: mq.size.width * 0.025,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                      ),
                    ),
                  ),
                  SizedBox(width: mq.size.width * 0.015),
                  Flexible(
                    child: Text(
                      author,
                      style: AppTextStyle.caption.copyWith(
                      color: Colors.black
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
          
          SizedBox(height: mq.size.height * 0.01),
          
          // Views count
          Text(
            "${item.likes} Dibaca",
            style: AppTextStyle.caption.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  
}
