import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/text_styles.dart';

class DetailStatsCard extends StatelessWidget {
  const DetailStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final stats = {
      "Rekomendasi": 13,
      "Dibaca": 481,
      "Diunduh": 9,
      "Dibagikan": 3,
    };

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(mq.size.width * 0.04), // Responsive padding
          child: Column(
            children: stats.entries.map((e) => _buildRow(e.key, e.value)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(label, style: AppTextStyle.bodyText.copyWith(fontSize: 16.sp)),
          const SizedBox(width: 8),
          const Expanded(child: Divider(thickness: 0.8, color: Colors.grey)),
          const SizedBox(width: 8),
          Text(value.toString(), style: AppTextStyle.cardTitle.copyWith(fontSize: 16.sp)),
        ],
      ),
    );
  }
}
