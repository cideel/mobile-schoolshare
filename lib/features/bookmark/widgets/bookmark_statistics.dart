import 'package:flutter/material.dart';
import '../../../core/constants/color.dart';
import '../../../core/constants/text_styles.dart';

class BookmarkStatistics extends StatelessWidget {
  final int viewCount;
  final int downloadCount;
  final int recommendationCount;

  const BookmarkStatistics({
    super.key,
    required this.viewCount,
    required this.downloadCount,
    required this.recommendationCount,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Row(
      children: [
        _StatItem(
          value: viewCount,
          label: 'Dibaca',
          fontSize: mq.size.width * 0.032,
        ),
        _Separator(fontSize: mq.size.width * 0.032),
        _StatItem(
          value: downloadCount,
          label: 'Unduh',
          fontSize: mq.size.width * 0.032,
        ),
        _Separator(fontSize: mq.size.width * 0.032),
        _StatItem(
          value: recommendationCount,
          label: 'Rekomendasi',
          fontSize: mq.size.width * 0.032,
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final int value;
  final String label;
  final double fontSize;

  const _StatItem({
    required this.value,
    required this.label,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$value',
          style: AppTextStyle.readCount.copyWith(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: AppColor.componentColor,
          ),
        ),
        Text(
          ' $label',
          style: AppTextStyle.readCount.copyWith(
            fontSize: fontSize,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

class _Separator extends StatelessWidget {
  final double fontSize;

  const _Separator({required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      ' • ',
      style: AppTextStyle.readCount.copyWith(
        fontSize: fontSize,
        color: Colors.grey.shade600,
      ),
    );
  }
}
