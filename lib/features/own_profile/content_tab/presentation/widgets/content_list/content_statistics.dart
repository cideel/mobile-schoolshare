import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class ContentStatistics extends StatelessWidget {
  final Map<String, dynamic> content;
  final MediaQueryData mediaQuery;

  const ContentStatistics({
    super.key,
    required this.content,
    required this.mediaQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildStatItem(Icons.visibility_outlined, '${content['dibaca'] ?? 0}', 'Dibaca'),
            const SizedBox(width: 16),
            _buildStatItem(Icons.download_outlined, '${content['diunduh'] ?? 0}', 'Diunduh'),
            const Spacer(),
            Text(
              content['publishedDate'] ?? 'Tanggal tidak tersedia',
              style: AppTextStyle.dateText.copyWith(fontSize: 12.sp),
            ),
          ],
        ),
        SizedBox(height: mediaQuery.size.height * 0.01),
        Row(
          children: [
            _buildStatItem(Icons.share_outlined, '${content['dibagikan'] ?? 0}', 'Dibagikan'),
            const SizedBox(width: 16),
            _buildStatItem(Icons.recommend_outlined, '${content['rekomendasi'] ?? 0}', 'Rekomendasi'),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String count, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 4),
        Text(
          '$count $label', // Fixed null safety
          style: AppTextStyle.readCount.copyWith(fontSize: 12.sp),
        ),
      ],
    );
  }
}
