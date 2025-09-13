import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class PublicationCard extends StatelessWidget {
  final String title;
  final String type;
  final String date;
  final List<Map<String, dynamic>> authors;
  final int reads;
  final VoidCallback? onTap;

  const PublicationCard({
    super.key,
    required this.title,
    required this.type,
    required this.date,
    required this.authors,
    required this.reads,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul
            Text(
              textAlign: TextAlign.start,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              title,
              style: AppTextStyle.cardTitle.copyWith(fontSize: 16.sp),
            ),
            SizedBox(height: mq.size.height * 0.008),
        
            // Tag
            Row(
              children: [
                _buildTag(type, bgColor: AppColor.componentColor),
                SizedBox(width: mq.size.width * 0.02),
                
              ],
            ),
            SizedBox(height: mq.size.height * 0.008),
        
            // Tanggal
            Text(
              date,
              style: AppTextStyle.dateText.copyWith(fontSize: 13.sp),
            ),
            SizedBox(height: mq.size.height * 0.008),
        
            // Authors
            Wrap(
              spacing: mq.size.width * 0.02,
              runSpacing: 4,
              children: authors
                  .map<Widget>((author) => _buildAuthor(author, mq))
                  .toList(),
            ),
            SizedBox(height: mq.size.height * 0.008),
        
            // Reads
            Text(
              "$reads Dibaca",
              style: AppTextStyle.readCount.copyWith(fontSize: 13.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, {Color? bgColor, bool border = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor ?? Colors.white,
        border: border ? Border.all(color: Colors.grey.shade400) : null,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: AppTextStyle.badge.copyWith(fontSize: 12.sp),
      ),
    );
  }

  Widget _buildAuthor(Map<String, dynamic> author, MediaQueryData mq) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: mq.size.width * 0.025,
          backgroundColor: Colors.grey.shade300,
          backgroundImage: author['photo'] != null ? AssetImage(author['photo']) : null,
          child: author['photo'] == null
              ? Icon(Icons.person, size: mq.size.width * 0.03, color: Colors.white)
              : null,
        ),
        SizedBox(width: mq.size.width * 0.015),
        Text(
          author['name'],
          style: AppTextStyle.authorName.copyWith(fontSize: 13.sp),
        )
      ],
    );
  }
}
