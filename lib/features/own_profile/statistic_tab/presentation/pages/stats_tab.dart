import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';

class StatsTab extends StatelessWidget {
  const StatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final horizontalPadding = mq.size.width * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Text(
              "Overview",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: const [
                Expanded(
                  child: InfoBox(score: "7,6", title: "RI Score"),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: InfoBox(score: "1000", title: "Dibaca"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Expanded(
                  child: InfoBox(score: "69", title: "Rekomendasi"),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: InfoBox(score: "12", title: "Sitasi"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.componentColor),
              ),
              child: InkWell(
                onTap: () {
                  // Aksi jika diklik
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.trending_up, color: AppColor.componentColor),
                    const SizedBox(width: 8),
                    Text(
                      "Lihat laporan status mingguan",
                      style: TextStyle(color: AppColor.componentColor),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(thickness: 0.5, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  final String score;
  final String title;
  final VoidCallback? onInfoPressed;

  const InfoBox({
    super.key,
    required this.score,
    required this.title,
    this.onInfoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 133, 129, 129)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              score,
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 17.sp),
                ),
                if (onInfoPressed != null)
                  IconButton(
                    icon: const Icon(Icons.info_outline, size: 18),
                    onPressed: onInfoPressed,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
