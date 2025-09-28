import 'package:flutter/material.dart';
import '../../../../core/constants/color.dart';
import '../../../../core/constants/text_styles.dart';

class ContentStatistics extends StatelessWidget {
  final int readCount;
  final int downloadCount;
  final int likeCount;

  const ContentStatistics({
    super.key,
    required this.readCount,
    required this.downloadCount,
    required this.likeCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatItem(
          count: '$readCount',
          label: 'Dibaca',
        ),
        _StatSeparator(),
        _StatItem(
          count: '$downloadCount',
          label: 'Unduh',
        ),
        _StatSeparator(),
        _StatItem(
          count: '$likeCount',
          label: 'Rekomendasi',
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String count;
  final String label;

  const _StatItem({
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: count,
            style: AppTextStyle.readCount.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColor.componentColor,
            ),
          ),
          TextSpan(
            text: ' $label',
            style: AppTextStyle.readCount,
          ),
        ],
      ),
    );
  }
}

class _StatSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      '  •  ',
      style: AppTextStyle.readCount.copyWith(
        color: Colors.grey.shade400,
      ),
    );
  }
}
