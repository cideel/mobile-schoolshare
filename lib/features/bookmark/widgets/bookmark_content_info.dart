import 'package:flutter/material.dart';
import '../../../core/constants/color.dart';
import '../../../core/constants/text_styles.dart';

class BookmarkContentInfo extends StatelessWidget {
  final String title;
  final String contentType;
  final DateTime date;

  const BookmarkContentInfo({
    super.key,
    required this.title,
    required this.contentType,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BookmarkTitle(title: title),
        SizedBox(height: mq.size.height * 0.008),
        _ContentTypeBadge(contentType: contentType),
        SizedBox(height: mq.size.height * 0.008),
        _BookmarkDate(date: date),
      ],
    );
  }
}

class _BookmarkTitle extends StatelessWidget {
  final String title;

  const _BookmarkTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Text(
      title,
      style: AppTextStyle.cardTitle.copyWith(
        fontSize: mq.size.width * 0.045,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
        height: 1.3,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _ContentTypeBadge extends StatelessWidget {
  final String contentType;

  const _ContentTypeBadge({required this.contentType});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: mq.size.width * 0.025,
        vertical: mq.size.height * 0.005,
      ),
      decoration: BoxDecoration(
        color: AppColor.componentColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        contentType,
        style: AppTextStyle.badge.copyWith(
          fontSize: mq.size.width * 0.03,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _BookmarkDate extends StatelessWidget {
  final DateTime date;

  const _BookmarkDate({required this.date});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Text(
      _formatDate(date),
      style: AppTextStyle.dateText.copyWith(
        fontSize: mq.size.width * 0.032,
        color: Colors.grey.shade600,
      ),
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