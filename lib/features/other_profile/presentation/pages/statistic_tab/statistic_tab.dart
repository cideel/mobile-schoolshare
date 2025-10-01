import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/data/models/users_model.dart';

class StatusTab extends StatelessWidget {
  final UserModel user;

  const StatusTab({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    // Buat map dinamis untuk statistik
    final stats = {
      "RI Score": user.riScore?.toString() ?? "0",
      "Dibaca": user.readDocs?.toString() ?? "0",
      "Rekomendasi": user.totalRecommendation?.toString() ?? "0",
      "Sitasi": user.totalSitasi?.toString() ?? "0",
    };

    return SingleChildScrollView(
      padding: EdgeInsets.all(mq.size.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: mq.size.width * 0.03,
            crossAxisSpacing: mq.size.width * 0.03,
            childAspectRatio: 1.5,
            children: stats.entries.map((entry) {
              return _buildStatCard(
                context,
                label: entry.key,
                value: entry.value,
                color: Colors.grey[100]!,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String value,
    required String label,
    required Color color,
  }) {
    final mq = MediaQuery.of(context);
    return Container(
      padding: EdgeInsets.all(mq.size.width * 0.04),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: AppTextStyle.titleLarge.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: mq.size.height * 0.005),
          Text(
            label,
            style: AppTextStyle.bodyText.copyWith(
              fontSize: 14.sp,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
