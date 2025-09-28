import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/color.dart';
import '../../../../core/constants/text_styles.dart';
import 'content_authors_list.dart';
import 'content_statistics.dart';

class ContentCard extends StatelessWidget {
  final String title;
  final String type;
  final DateTime publishedDate;
  final List<String> authors;
  final int readCount;
  final int downloadCount;
  final int likeCount;

  const ContentCard({
    super.key,
    required this.title,
    required this.type,
    required this.publishedDate,
    required this.authors,
    required this.readCount,
    required this.downloadCount,
    required this.likeCount,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: Colors.grey, width: 0.3),
        ),
        child: Padding(
          padding: EdgeInsets.all(mq.size.width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ContentTitle(title: title),
              SizedBox(height: mq.size.height * 0.008),
              _ContentTypeBadge(type: type),
              SizedBox(height: mq.size.height * 0.008),
              _ContentDate(date: publishedDate),
              SizedBox(height: mq.size.height * 0.012),
              ContentAuthorsList(authors: authors),
              SizedBox(height: mq.size.height * 0.012),
              ContentStatistics(
                readCount: readCount,
                downloadCount: downloadCount,
                likeCount: likeCount,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContentTitle extends StatelessWidget {
  final String title;

  const _ContentTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyle.titleLarge.copyWith(fontSize: 18.sp),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _ContentTypeBadge extends StatelessWidget {
  final String type;

  const _ContentTypeBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.r),
        color: AppColor.componentColor,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: mq.size.width * 0.015,
        vertical: mq.size.height * 0.004,
      ),
      child: Text(
        type,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class _ContentDate extends StatelessWidget {
  final DateTime date;

  const _ContentDate({required this.date});

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatDate(date),
      style: AppTextStyle.dateText,
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
