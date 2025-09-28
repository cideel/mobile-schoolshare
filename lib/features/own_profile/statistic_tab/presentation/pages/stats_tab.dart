// lib/features/own_profile/statistic_tab/presentation/pages/stats_tab.dart (Diperbarui)
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/features/own_profile/controllers/statistic_tab_controller.dart';

class StatsTab extends StatelessWidget {
  // Ambil Controller
  final StatisticTabController controller = Get.find<StatisticTabController>();

  StatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final horizontalPadding = mq.size.width * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),

        // 🔥 Gunakan OBX untuk membuat tampilan reaktif terhadap status data
        child: controller.obx(
          (user) {
            // Data sudah sukses dimuat, kini gunakan Obx di dalam ListView
            return ListView(
              children: [
                const SizedBox(height: 20),
                Text(
                  "Overview",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Gunakan Obx untuk memperbarui InfoBox secara independen
                Obx(() => Row(
                      children: [
                        Expanded(
                          // Data RI Score
                          child: InfoBox(
                              score: controller.riScore.value,
                              title: "RI Score"),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          // Data Dibaca
                          child: InfoBox(
                              score: controller.readDocs.value,
                              title: "Dibaca"),
                        ),
                      ],
                    )),
                const SizedBox(height: 10),
                Obx(() => Row(
                      children: [
                        Expanded(
                          // Data Rekomendasi
                          child: InfoBox(
                              score: controller.recommendation.value,
                              title: "Rekomendasi"),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          // Data Sitasi
                          child: InfoBox(
                              score: controller.sitasi.value, title: "Sitasi"),
                        ),
                      ],
                    )),
                const SizedBox(height: 20),

                // Button tetap statis
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
            );
          },
          // Tampilkan loading saat fetch data
          onLoading: const Center(child: CircularProgressIndicator()),
          // Tampilkan error jika terjadi
          onError: (error) =>
              Center(child: Text("Gagal memuat statistik: $error")),
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
    // ... (kode InfoBox tetap sama) ...
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
