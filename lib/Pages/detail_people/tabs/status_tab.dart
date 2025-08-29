import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/text_styles.dart';

class StatusTab extends StatelessWidget {
  const StatusTab({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return SingleChildScrollView(
      padding: EdgeInsets.all(mq.size.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Statistics Cards
          _buildStatisticsGrid(context),
        ],
      ),
    );
  }

  Widget _buildStatisticsGrid(BuildContext context) {
    final mq = MediaQuery.of(context);
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: mq.size.width * 0.03,
      crossAxisSpacing: mq.size.width * 0.03,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard(
          context,
          value: "7,6",
          label: "RI Score",
          color: Colors.grey[100]!,
        ),
        _buildStatCard(
          context,
          value: "1000",
          label: "Dibaca",
          color: Colors.grey[100]!,
        ),
        _buildStatCard(
          context,
          value: "69",
          label: "Rekomendasi",
          color: Colors.grey[100]!,
        ),
        _buildStatCard(
          context,
          value: "12",
          label: "Sitasi",
          color: Colors.grey[100]!,
        ),
      ],
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
